
import UIKit
import ReSwift

private let REUSE_IDENTIFIER = "PhotoCell"

class DragDropViewController: UICollectionViewController, PEditorControllerDelegate  {
	
	private var dataItems:[DragItemModel] = []
	private var placeholderItem:DragItemModel = DragItemModel(type: "", content:"", clr: Constants.COLORS.PLACEHOLDER, imageSrc: "add.png")
	private var clickPos:ClickPos?
	private var placeholderIndex:Int = -1
	private var draggedIndex:IndexPath?
	private var _key:String = ""
	var dragDelegate : PDragDelegate?
	
	init(collectionViewLayout: UICollectionViewLayout, key:String){
		_key = key
		super.init(collectionViewLayout:collectionViewLayout)
		self.collectionView?.backgroundColor = .clear
		self.view.clipsToBounds = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func updateData(index:Int, model: DragItemModel){
		store.dispatch(UpdateItemAction(payload: Edit(index: index, model: model, key:_key)))
	}
	
	func moveDataItem(sIndex: Int, _ dIndex: Int) {
		let item = dataItems.remove(at: sIndex)
		dataItems.insert(item, at:dIndex)
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
			let index:Int = self.getIndexAt(x: Double(clickPos.pos.x), y: Double(clickPos.pos.y), allowEnd: false)
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
	
	func getIndexAt(x:Double, y:Double, allowEnd:Bool = true) -> Int{
		var numX:Int = Int(floor(x/60.0))
		let min = 0
		let max = allowEnd ? self.dataItems.count : self.dataItems.count - 1
		if(numX < min){
			numX = min
		}
		if(numX > max){
			numX = max
		}
		return numX
	}
	
	func getAllPaths() -> [IndexPath]{
		return getPaths(self.dataItems.count)
	}
	
	func setData(items:DragItems){
		dataItems = items
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
	
	@objc(collectionView:layout:insetForSectionAtIndex:)
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(5, 5, 5, 5)
	}
	
	@objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:)
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 5
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.installsStandardGestureForInteractiveMovement = true
		self.collectionView?.backgroundColor = .clear
		let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
		self.collectionView?.addGestureRecognizer(longPressGesture)
		longPressGesture.minimumPressDuration = 0.0000001
		self.view.backgroundColor = .clear
		self.collectionView?.backgroundColor = .clear
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
		self.insert(d: DragItemModel(type: type, content:"", clr: .red, imageSrc: src), index: index)
	}
	
	public func deleteAt(index:Int){
		UIView.setAnimationsEnabled(false)
		self.dataItems = MathUtils.getDeletedAt(a:self.dataItems, index:index)
		self.collectionView?.deleteItems(at: [IndexPath(row:index, section: 0)])
		UIView.setAnimationsEnabled(true)
	}

}

