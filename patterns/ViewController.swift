
import UIKit
import RSClipperWrapper
import ReSwift

class GDelegate : NSObject, UIGestureRecognizerDelegate {
	func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		return true
	}
}

class ViewController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	
	private var drawingController:DrawingViewController
	private var textEntryController:TextEntryController
	private var dragController:DragDropViewController
	private var listController:ListController
	private var gDel:UIGestureRecognizerDelegate
	
	required init?(frame: CGRect) {
		gDel = GDelegate()
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		self.listController = ListController(_gDel:gDel)
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: 60, height: 60)
		flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
		flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
		flowLayout.minimumInteritemSpacing = 0.0
		self.dragController = DragDropViewController(collectionViewLayout: flowLayout, _gDel:gDel)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		gDel = GDelegate()
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		self.listController = ListController(_gDel:gDel)
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.itemSize = CGSize(width: 60, height: 60)
		flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
		flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
		flowLayout.minimumInteritemSpacing = 0.0
		self.dragController = DragDropViewController(collectionViewLayout: flowLayout, _gDel:gDel)
		super.init(nibName: nil, bundle: nil)
	}
	
	func addChildren(){
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.displayContentController(content: drawingController, frame: self.view.frame)
		self.displayContentController(content: textEntryController, frame: CGRect(x: 0, y: 0, width: 600, height: 400))
		self.displayContentController(content: dragController, frame: CGRect(x: 0, y: self.view.frame.height/2.0, width: self.view.frame.width, height: self.view.frame.height/2.0))
		self.displayContentController(content: listController, frame: CGRect(x: 0, y: self.view.frame.height/2.0, width: self.view.frame.width, height: self.view.frame.height/2.0))
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
			self.dragController.insert(src: "img1.png", index: 8)
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
	
	func newState(state: AppState) {
		print("newstate")
	}
	
	func displayContentController(content: UIViewController, frame:CGRect){
		addChildViewController(content)
		self.view.addSubview(content.view)
		content.view.frame = frame
		content.didMove(toParentViewController: self)
	}
	
	func hideContentController(content: UIViewController) {
		content.willMove(toParentViewController: nil)
		content.view.removeFromSuperview()
		content.removeFromParentViewController()
	}


}

