
import UIKit
import RSClipperWrapper
import ReSwift

class DesignViewController: UIViewController, StoreSubscriber, PPageViewController {
	
	typealias StoreSubscriberStateType = AppState
	
	private var drawingController:DrawingViewController
	private var textEntryController:TextEntryController
	private var tabButtonsController:TabButtonsController
	private var tabContentController:TabContentController
	
	required init(){
		self.tabButtonsController = TabButtonsController()
		self.tabContentController = TabContentController()
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func getName() -> String {
		return "design"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let h:CGFloat = self.view.frame.height/2.0;
		displayContentController(container: self, content: drawingController, frame: self.view.frame)
		displayContentController(container: self, content: textEntryController, frame: CGRect(x: 0, y: 0, width: 600, height: 400))
		displayContentController(container: self, content: tabButtonsController, frame: CGRect(x: 0, y: h-50, width: self.view.frame.width, height: 50))
		displayContentController(container: self, content: tabContentController, frame: CGRect(x: 0, y: h, width: self.view.frame.width, height: h))
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
		print("newstate", state)
	}

}

