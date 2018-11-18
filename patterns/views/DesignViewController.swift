
import UIKit
import RSClipperWrapper
import ReSwift

class DesignViewController: UIViewController, StoreSubscriber, PPageViewController {
	
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
		displayContentController(container: self, content: drawingController)
		displayContentController(container: self, content: textEntryController)
		displayContentController(container: self, content: tabButtonsController)
		displayContentController(container: self, content: tabContentController)
		self.initLayout()
	}
	
	func initLayout(){
		LayoutUtils.layoutToBottom(v: self.tabContentController.view, parent: self.view, multiplier: 0.5)
		//LayoutUtils.layoutToTop(v: self.textEntryController.view, parent: self.view, multiplier: 0)
		LayoutUtils.layoutFull(v: self.drawingController.view, parent: self.view)
		LayoutUtils.layoutAboveWithHeight(v: self.tabButtonsController.view, viewToBeAbove: self.tabContentController.view, height: 60)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.selectedTabState
				}
				.skipRepeats()
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: Int) {
		print("design state", state)
		self.tabButtonsController.setSelected(state)
		self.tabContentController.setSelected(state)
	}

}

