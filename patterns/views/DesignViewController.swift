
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
		displayContentController(container: self, content: drawingController, frame: self.view.frame)
		displayContentController(container: self, content: textEntryController, frame: CGRect(x: 0, y: 0, width: 600, height: 400))
		displayContentController(container: self, content: tabButtonsController, frame: CGRect(x: 10, y: h-60, width: self.view.frame.width-20, height: 50))
		displayContentController(container: self, content: tabContentController, frame: CGRect(x: 10, y: h + 20, width: self.view.frame.width - 20, height: h - 40))
		self.initLayout()
	}
	
	func initLayout(){
		LayoutUtils.layoutToTop(v: self.tabContentController.view, parent: self.view, multiplier: 0.5)
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

