
import UIKit
import ReSwift

private let REUSE_IDENTIFIER = "PhotoCell"

class DragDropViewController: UICollectionViewController, StoreSubscriber, PEditorControllerDelegate  {
	private var dataItems:[DragItemModel] = []
	private var placeholderItem:DragItemModel = DragItemModel(type: "temp", label: "fd", imageSrc: "img2.png")
	private var clickPos:ClickPos?
	private var placeholderIndex:Int = -1
	private var draggedIndex:IndexPath?
	var dragDelegate : PDragDelegate?
	
	override init(collectionViewLayout: UICollectionViewLayout){
		super.init(collectionViewLayout:collectionViewLayout)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateData(index:Int, model: DragItemModel){
		store.dispatch(UpdateItemAction(payload: Edit(index: index, model: model)))
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
		self.view.backgroundColor = UIColor.red
	}

	@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
		if(gesture.state == .began){
			guard let selectedIndexPath:IndexPath = self.collectionView?.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
				return
			}
			self.draggedIndex = selectedIndexPath
			clickPos = ClickPos(pos: gesture.location(in: self.view), time: Date().timeIntervalSince1970)
			self.collectionView?.beginInteractiveMovementForItem(at: selectedIndexPath)
		}
		else if(gesture.state == .changed){
			self.collectionView?.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
		}
		else if(gesture.state == .ended){
			self.collectionView?.endInteractiveMovement()
			let pos:CGPoint = gesture.location(in: self.view)
			self.checkClick(clickPos:ClickPos(pos: pos, time: Date().timeIntervalSince1970))
			if (self.dragDelegate) != nil{
				dragDelegate?.onDragEnd(index:self.draggedIndex!, pos:pos)
			}
		}
		else{
			self.collectionView?.cancelInteractiveMovement()
		}
	}

	func checkClick(clickPos:ClickPos){
		if(clickPos.isCloseTo(clickPos: self.clickPos!)){
			let index:Int = self.getIndexAt(x: Double(clickPos.pos.x), y: Double(clickPos.pos.y))
			let data = self.dataItems[index]
			let cell = collectionView!.cellForItem(at: IndexPath(row:index, section: 0))
			let editor = EditorViewController()
			editor.delegate = self
			editor.preferredContentSize = CGSize(width: 400, height: 300)
			editor.modalPresentationStyle = .popover
			editor.loadData(index, data)
			let popover = editor.popoverPresentationController
			popover?.sourceView = self.view
			popover?.sourceRect = (cell?.frame)!
			self.present(editor, animated: true, completion: nil)
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
	
	func getPaths(_ num:Int) -> [IndexPath]{
		var p:[IndexPath] = []
		for i in 0..<num{
			p.append(IndexPath(row:i, section: 0))
		}
		return p
	}
	
	func getAllPaths() -> [IndexPath]{
		return getPaths(self.dataItems.count)
	}
	
	func newState(state: DragItems) {
		dataItems = state
		UIView.setAnimationsEnabled(false)
		self.collectionView?.reloadData()
		self.collectionView?.reloadItems(at: getAllPaths())
		UIView.setAnimationsEnabled(true)
	}
	
	func movePlaceholder(index:Int){
		var numActualDataItems:Int
		var newIndex:Int
		if(self.placeholderIndex != index){
			if(self.placeholderIndex >= 0){
				// it existed
				numActualDataItems = self.dataItems.count - 1
				if(index >= 0 && index != self.placeholderIndex){
					newIndex = min(numActualDataItems, index)
					self.move(from: self.placeholderIndex, to: newIndex)
				}
				else{
					newIndex = -1
					self.deleteAt(index: self.placeholderIndex)
				}
			}
			else{
				// didnt exist
				numActualDataItems = self.dataItems.count
				if(index >= 0){
					newIndex = min(numActualDataItems, index)
					self.insert(d: placeholderItem, index: min(numActualDataItems, index))
				}
				else{
					newIndex = -1
				}
			}
			self.placeholderIndex = newIndex
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
			.select {
				$0.items
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
	
	@objc(collectionView:layout:insetForSectionAtIndex:)
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(5, 5, 5, 5)
	}
	
	@objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:)
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 5
	}
	
	@objc(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 5
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
		UIView.setAnimationsEnabled(false)
		self.dataItems = MathUtils.getDeletedAt(a:self.dataItems, index:index)
		self.collectionView?.deleteItems(at: [IndexPath(row:index, section: 0)])
		UIView.setAnimationsEnabled(true)
	}
	
	
}

