
import UIKit
import ReSwift

private let reuseIdentifier = "PhotoCell"

class PhotoCell: UICollectionViewCell {
	var imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
		self.addSubview(imageView)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(imageView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class Photo {
	var imageData: Data
	init(imageData: Data) {
		self.imageData = imageData
	}
}

class DragDropViewController: UICollectionViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	var gDel:UIGestureRecognizerDelegate
	
	var dataItems:[Photo] = {
		var photos = [] as [Photo]
		for index in 0...35 {
			let image:UIImage = UIImage(named: "img.png")!
			let imageData:Data? = UIImagePNGRepresentation(image)
			photos.append(Photo(imageData: imageData!))
		}
		return photos
	}()
	
	init(collectionViewLayout: UICollectionViewLayout, _gDel:UIGestureRecognizerDelegate){
		self.gDel = _gDel
		super.init(collectionViewLayout:collectionViewLayout)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func moveDataItem(sIndex: Int, _ dIndex: Int) {
		let item = dataItems.remove(at: sIndex)
		dataItems.insert(item, at:dIndex)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.installsStandardGestureForInteractiveMovement = true
		self.view.backgroundColor = UIColor.cyan
		let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
		self.collectionView?.addGestureRecognizer(longPressGesture)
		longPressGesture.delegate = self.gDel
	}
	
	@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
		switch(gesture.state) {
			case .began:
				guard let selectedIndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
					break
				}
				self.collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
			case .changed:
				self.collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
			case .ended:
				self.collectionView?.endInteractiveMovement()
			default:
				self.collectionView?.cancelInteractiveMovement()
		}
	}
	
	func newState(state: AppState) {
		print("new state", state)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
		return dataItems.count
	}
	
	override public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool{
		return true
	}
	
	override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
		collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
		let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath)
		let index:Int = IndexUtils.indexOf(indexPath: indexPath)
		if let cell = cell as? PhotoCell{
			cell.imageView.image = UIImage(data: dataItems[index].imageData)
		}
		return cell
	}
	
	override public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
		let sIndex:Int = IndexUtils.indexOf(indexPath: sourceIndexPath)
		let dIndex:Int = IndexUtils.indexOf(indexPath: destinationIndexPath)
		moveDataItem(sIndex: sIndex, dIndex)
	}
	
	public func insert(src:String, index:Int){
		let image:UIImage = UIImage(named: src)!
		let imageData:Data? = UIImagePNGRepresentation(image)
		dataItems.insert(Photo(imageData: imageData!), at: index)
		let indexPath = IndexPath(row:index, section: 0)
		self.collectionView?.insertItems(at: [indexPath])
	}

}

