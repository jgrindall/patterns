
import UIKit
import ReSwift

private let REUSE_IDENTIFIER = "PhotoCell"

class DragDropViewController: UICollectionViewController  {
	
	private var dataItems:[DragItemModel] = []
    private var placeholderItem:DragItemModel = DragItemModel(type: "temp", label: "fd", imageSrc: "img2.png")
	private var clickPos:ClickPos?
	private var placeholderIndex:Int = -1
	private var draggedIndex:IndexPath?
	private var _key:String = ""
	var dragDelegate : PDragDelegate?
	
	init(collectionViewLayout: UICollectionViewLayout, key:String, frame:CGRect){
		_key = key
		super.init(collectionViewLayout:collectionViewLayout)
		self.collectionView?.backgroundColor = UIColor.brown
		self.view.frame  = frame
		self.collectionView?.frame  = frame
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.installsStandardGestureForInteractiveMovement = true
		self.collectionView?.backgroundColor = UIColor.cyan
		//let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
		//self.collectionView?.addGestureRecognizer(longPressGesture)
		//longPressGesture.minimumPressDuration = 0.0000001
		self.view.backgroundColor = UIColor.cyan
		print("1",self.view.frame)
		print("2",self.collectionView?.frame)
		self.collectionView?.backgroundColor = .yellow
		self.view.layer.borderWidth = 13
		self.view.layer.borderColor = UIColor.yellow.cgColor
		self.collectionView?.layer.borderWidth = 13
		self.collectionView?.layer.borderColor = UIColor.yellow.cgColor
		
	}

}

