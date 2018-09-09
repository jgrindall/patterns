
import UIKit
import ReSwift

private let REUSE_IDENTIFIER = "PhotoCell"

class DragDropViewController: UICollectionViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	var gDel:UIGestureRecognizerDelegate
	var dataItems:[DragItemModel] = []
	var placeholderItem:DragItemModel = DragItemModel(type: "temp", label: "fd", imageSrc: "img2.png")
	
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
		self.collectionView?.backgroundColor = .green
		longPressGesture.minimumPressDuration = 0.0001
		longPressGesture.delegate = self.gDel
	}
	
	@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
		if(gesture.state == .began){
			guard let selectedIndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
				return
			}
			self.collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
		}
		else if(gesture.state == .changed){
			self.collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
		}
		else if(gesture.state == .ended){
			self.collectionView?.endInteractiveMovement()
		}
		else{
			self.collectionView?.cancelInteractiveMovement()
		}
	}
	
	func getPlaceHolderIndex() -> Int{
		if let index:Int = dataItems.index(where: {$0.type == "temp"}) {
			return index
		}
		else {
			return -1
		}
	}
	
	func getPaths() -> [IndexPath]{
		var p:[IndexPath] = []
		for i in 0..<dataItems.count{
			p.append(IndexPath(row:i, section: 0))
		}
		return p
	}
	
	func newState(state: AppState) {
		if(state.dragState == "dragging"){
			movePlaceholder(newIndex:state.placeholderIndex)
		}
		if(state.dragState == "idle"){
			movePlaceholder(newIndex:-1)
			dataItems = state.dataItems
			for i in 0..<dataItems.count{
				print (i, dataItems[i].imageSrc)
			}
			
			UIView.setAnimationsEnabled(false)
			self.collectionView?.performBatchUpdates({
				self.collectionView?.reloadItems(at: getPaths())
				self.collectionView?.reloadData()
			}, completion: { (done:Bool) in
				UIView.setAnimationsEnabled(true)
			})
		}
	}
	
	func movePlaceholder(newIndex:Int){
		let currentIndex = getPlaceHolderIndex()
		if(currentIndex >= 0){
			// it existed
			if(newIndex >= 0){
				// moved
				self.move(from: currentIndex, to: newIndex)
			}
			else{
				// deleted
				self.deleteAt(index: currentIndex)
			}
		}
		else{
			// didnt exist
			if(newIndex >= 0){
				// add
				self.insert(d: placeholderItem, index: newIndex)
			}
			else{
				// nothing
			}
		}
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
		collectionView.register(ItemCell.self, forCellWithReuseIdentifier: REUSE_IDENTIFIER)
		let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath as IndexPath)
		let index:Int = IndexUtils.indexOf(indexPath: indexPath)
		if let cell = cell as? ItemCell{
			cell.loadData(p:dataItems[index])
		}
		return cell
	}
	
	override public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath){
		let sIndex:Int = IndexUtils.indexOf(indexPath: sourceIndexPath)
		let dIndex:Int = IndexUtils.indexOf(indexPath: destinationIndexPath)
		moveDataItem(sIndex: sIndex, dIndex)
	}
	
	public func move(from:Int, to:Int){
		let element = self.dataItems.remove(at: from)
		self.dataItems.insert(element, at:to)
		self.collectionView?.moveItem(at: IndexPath(row:from, section: 0), to: IndexPath(row:to, section: 0))
	}
	
	public func insert(d:DragItemModel, index:Int){
		if(index >= dataItems.count){
			self.dataItems.append(d)
		}
		else{
			self.dataItems.insert(d, at: index)
		}
		self.collectionView?.insertItems(at: [IndexPath(row:index, section: 0)])
	}
	
	public func insert(type:String, src:String, index:Int){
		self.insert(d: DragItemModel(type: type, label: "fd", imageSrc: src), index: index)
	}
	
	public func deleteAt(index:Int){
		dataItems = MathUtils.getDeletedAt(a:self.dataItems, index:index)
		self.collectionView?.deleteItems(at: [IndexPath(row:index, section: 0)])
	}
	
	
}

