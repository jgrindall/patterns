
import UIKit
import RSClipperWrapper
import ReSwift

class DesignViewController: UIViewController, StoreSubscriber, PPageViewController {
	
	private var drawingController:DrawingViewController
	private var drawingConstraints:[NSLayoutConstraint] = []
	private var textEntryController:TextEntryController
	private var tabButtonsController:TabButtonsController
	private var tabButtonsConstraints:[NSLayoutConstraint] = []
	private var tabContentController:TabContentController
	private var tabContentConstraints:[NSLayoutConstraint] = []
	
	required init(){
		self.tabButtonsController = TabButtonsController()
		self.tabContentController = TabContentController()
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		super.init(nibName: nil, bundle: nil)
		self.title = "Edit your file"
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func getName() -> String {
		return "design"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		displayContentController(container: self, content: drawingController)
		displayContentController(container: self, content: textEntryController)
		displayContentController(container: self, content: tabButtonsController)
		displayContentController(container: self, content: tabContentController)
		self.initLayout()
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
			UIView.animate(withDuration: 1, animations: {
				self.tabContentController.view.frame.origin.y += 200
			}, completion: nil)
		}
		
	}
	
	func initLayout(){
		drawingConstraints = LayoutUtils.layoutFull(v: self.drawingController.view, parent: self.view)
		tabContentConstraints = LayoutUtils.layoutToBottom(v: self.tabContentController.view, parent: self.view, multiplier: 0.5)
		tabButtonsConstraints = LayoutUtils.layoutAboveWithHeight(v: self.tabButtonsController.view, viewToBeAbove: self.tabContentController.view, height: 60)
		
		self.drawingController.view.translatesAutoresizingMaskIntoConstraints = false
		self.tabContentController.view.translatesAutoresizingMaskIntoConstraints = false
		self.tabButtonsController.view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(drawingConstraints)
		NSLayoutConstraint.activate(tabContentConstraints)
		NSLayoutConstraint.activate(tabButtonsConstraints)
		
		//LayoutUtils.layoutToTop(v: self.textEntryController.view, parent: self.view, multiplier: 0)
		
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
		self.tabButtonsController.setSelected(state)
		self.tabContentController.setSelected(state)
	}

}

