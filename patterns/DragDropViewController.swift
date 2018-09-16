
import UIKit
import ReSwift

private let REUSE_IDENTIFIER = "PhotoCell"

class EditorViewController:UIViewController{
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.orange
	}
}

struct ClickPos{
	var pos:CGPoint
	var time:TimeInterval
	func isCloseTo(clickPos:ClickPos) -> Bool {
		let p0 = clickPos.pos
		let p1 = self.pos
		let dx = p0.x - p1.x
		let dy = p0.y - p1.y
		let dt = clickPos.time - self.time
		return (abs(dx) < 10 && abs(dy) < 10 && abs(dt) < 500)
	}
}

class DragDropViewController: UICollectionViewController, StoreSubscriber {
	
	var gDel:UIGestureRecognizerDelegate
	var dataItems:[DragItemModel] = []
	var placeholderItem:DragItemModel = DragItemModel(type: "temp", label: "fd", imageSrc: "img2.png")
	var clickPos:ClickPos?
	
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
		self.collectionView?.backgroundColor = UIColor.cyan
		longPressGesture.minimumPressDuration = 0.0000001
		longPressGesture.delegate = self.gDel
		self.view.backgroundColor = UIColor.red
	}

	@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
		if(gesture.state == .began){
			guard let selectedIndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
				return
			}
			clickPos = ClickPos(pos: gesture.location(in: self.view), time: Date().timeIntervalSince1970)
			self.collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
		}
		else if(gesture.state == .changed){
			self.collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
		}
		else if(gesture.state == .ended){
			self.collectionView?.endInteractiveMovement()
			self.checkClick(clickPos:ClickPos(pos: gesture.location(in: self.view), time: Date().timeIntervalSince1970))
		}
		else{
			self.collectionView?.cancelInteractiveMovement()
		}
	}
	
	func checkClick(clickPos:ClickPos){
		if(clickPos.isCloseTo(clickPos: self.clickPos!)){
			let editor = EditorViewController()
			editor.preferredContentSize = CGSize(width: 400, height: 300)
			editor.modalPresentationStyle = .popover
			let popover = editor.popoverPresentationController
			popover?.sourceView = self.view
			popover?.sourceRect = CGRect(x: clickPos.pos.x, y: clickPos.pos.y, width: 64, height: 64)
			self.present(editor, animated: true, completion: nil)
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
	
	func getIndexAt(x:Double, y:Double) -> Int{
		var numX:Int = Int(floor(x/60.0))
		let min = 0
		let max = self.dataItems.count
		if(numX < min){
			numX = min
		}
		if(numX > max){
			numX = max
		}
		return numX
	}
	
	func getAllPaths() -> [IndexPath]{
		var p:[IndexPath] = []
		for i in 0..<self.dataItems.count{
			p.append(IndexPath(row:i, section: 0))
		}
		return p
	}
	
	func newState(state: (dragState: DragState, items: DragItems)) {
		if(state.dragState.state == .dragging){
			movePlaceholder(newIndex:state.dragState.placeholderIndex)
		}
		if(state.dragState.state == .idle){
			movePlaceholder(newIndex:-1)
			dataItems = state.items
			UIView.setAnimationsEnabled(false)
			self.collectionView?.performBatchUpdates({
				self.collectionView?.reloadItems(at: getAllPaths())
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
		store.subscribe(self) {
			$0
			.select {
				(dragState:$0.dragState, items:$0.items)
			}
			.skipRepeats{
				return $0.dragState == $1.dragState
			}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath)
	}
	
	override public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
		print(indexPath)
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

