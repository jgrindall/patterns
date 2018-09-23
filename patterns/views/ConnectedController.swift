
import UIKit
import RSClipperWrapper
import ReSwift

protocol PDragDelegate{
	func onDragEnd(index:IndexPath, pos:CGPoint)
}

class ConnectedController: UIViewController, StoreSubscriber, PDragDelegate {
	
	typealias StoreSubscriberStateType = AppState
	
	private var dragController:DragDropViewController
	private var listController:ListController
	private var delButton:UIImageView = UIImageView(frame: CGRect(x: 700, y: 100, width: 60, height: 60))
	
	init(frame:CGRect){
		self.listController = ListController()
		listController.view.backgroundColor = UIColor.purple
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: 60, height: 60)
		flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
		flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
		flowLayout.minimumInteritemSpacing = 0.0
		self.dragController = DragDropViewController(collectionViewLayout: flowLayout)
		dragController.view.backgroundColor = .green
		super.init(nibName: nil, bundle: nil)
		self.delButton.image = UIImage(named: "del.png")
		self.view.addSubview(self.delButton)
		self.view.frame = frame
	}
	
	func onDragEnd(index:IndexPath, pos:CGPoint) {
		let delFrame:CGRect = self.delButton.frame
		if(delFrame.contains(pos)){
			store.dispatch(DeleteItemAction(payload: index.row))
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let h:CGFloat = self.view.frame.height/4.0
		let w:CGFloat = self.view.frame.width
		displayContentController(container:self, content: dragController, frame: CGRect(x: 0, y: 0, width: w, height: h))
		displayContentController(container:self, content: listController, frame: CGRect(x: 0, y: h, width: w, height: h))
		self.listController.setTarget(target:self.dragController)
		self.dragController.dragDelegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: AppState) {
		//print("newstate")
	}
	
	
}

