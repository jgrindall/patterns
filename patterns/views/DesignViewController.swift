
import UIKit
import RSClipperWrapper
import ReSwift

class DesignViewController: UIViewController, StoreSubscriber, PPageViewController {
	
	private var drawingController:DrawingViewController
	private var drawingConstraints:[NSLayoutConstraint] = []
	private var textEntryController:TextEntryController
	private var tabController:TabController
	private var tabConstraints:[NSLayoutConstraint] = []
	private var openButton:UIButton = UIButton(frame: CGRect())
	private var openConstraints:[NSLayoutConstraint] = []
	
	required init(){
		self.tabController = TabController()
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		super.init(nibName: nil, bundle: nil)
		self.title = "Edit your file"
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
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
		displayContentController(container: self, content: tabController)
		openButton.setTitle("@OPEN", for: .normal)
		openButton.addTarget(self, action: #selector(DesignViewController.openButtonClicked(_:)), for: .touchUpInside)
		self.view.addSubview(openButton)
		self.initLayout()
		let g = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
		self.view.addGestureRecognizer(g)
	}
	
	@objc func openButtonClicked(_ sender:UITapGestureRecognizer){
		store.dispatch(SetUIStateAction(payload: .up))
	}
	
	@objc func someAction(_ sender:UITapGestureRecognizer){
		store.dispatch(SetUIStateAction(payload: .down))
	}
	
	func initLayout(){
		drawingConstraints = LayoutUtils.layoutFull(v: self.drawingController.view, parent: self.view)
		tabConstraints = LayoutUtils.layoutToBottom(v: self.tabController.view, parent: self.view, multiplier: 0.5)
		openConstraints = LayoutUtils.bottomRight(v: self.openButton, parent: self.view, margin: 0, width: 50, height: 50)
		
		self.drawingController.view.translatesAutoresizingMaskIntoConstraints = false
		self.tabController.view.translatesAutoresizingMaskIntoConstraints = false
		openButton.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(drawingConstraints)
		NSLayoutConstraint.activate(tabConstraints)
		NSLayoutConstraint.activate(openConstraints)
		
		//LayoutUtils.layoutToTop(v: self.textEntryController.view, parent: self.view, multiplier: 0)
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					($0.selectedTabState, $0.uiState)
				}
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: (selectedTabState:Int, uiState:UIState)) {
		self.tabController.setSelected(state.selectedTabState)
		self.openButton.isHidden = (state.uiState == .up)
	}

}

