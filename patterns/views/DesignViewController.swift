
import UIKit
import RSClipperWrapper
import ReSwift

class DesignViewController: UIViewController, PPageViewController, PColorPickerDelegate, PLineWidthDelegate, UIPopoverPresentationControllerDelegate, ConfigDelegate {
	
	private var drawingController:DrawingViewController
	private var drawingConstraints:[NSLayoutConstraint] = []
	private var textEntryController:TextEntryController
	private var tabController:TabController
	private var tabConstraints:[NSLayoutConstraint] = []
	private var openButton:UIButton = UIButton(frame: CGRect())
	private var openConstraints:[NSLayoutConstraint] = []
	private var selectedColor:UIColor?
	private var config:ConfigView?
	private var input:String = ""
	
	private lazy var state1Subscriber: BlockSubscriber<Int> = BlockSubscriber(block: {state in
		self.newState(state: state)
	})
	private lazy var state2Subscriber: BlockSubscriber<UIState> = BlockSubscriber(block: {state in
		self.newState(state: state)
	})
	private lazy var state3Subscriber: BlockSubscriber<DrawingConfigState> = BlockSubscriber(block: {state in
		self.newState(state: state)
	})
	
	required init(){
		self.tabController = TabController()
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		super.init(nibName: nil, bundle: nil)
		self.title = "Edit your file"
	}
	
	func colorChosen(color: UIColor) {
		if(input == "3"){
			store.dispatch(SetBgStateAction(payload: color))
		}
		else if(input == "2"){
			store.dispatch(SetFgStateAction(payload: color))
		}
		self.dismiss(animated: false, completion: nil)
	}
	
	func widthChosen(width: CGFloat) {
		if(input == "1"){
			store.dispatch(SetLineWidthStateAction(payload: width))
		}
		self.dismiss(animated: false, completion: nil)
	}
	
	func didReceiveConfig(input: String){
		self.input = input
		if(input == "2" || input == "3"){
			let editor = ColorPickerViewController()
			editor.delegate = self
			editor.preferredContentSize = CGSize(width: Constants.SIZE.COLOR_SWATCH_SIZE*2.0, height: 350)
			editor.modalPresentationStyle = .popover
			let popover = editor.popoverPresentationController
			popover?.sourceView = self.view
			popover?.sourceRect = (config?.frame)!
			self.present(editor, animated: true, completion: nil)
		}
		else{
			let editor = LineWidthViewController()
			editor.delegate = self
			editor.preferredContentSize = CGSize(width: 500, height: 500)
			editor.modalPresentationStyle = .popover
			let popover = editor.popoverPresentationController
			popover?.sourceView = self.view
			popover?.sourceRect = (config?.frame)!
			self.present(editor, animated: true, completion: nil)
		}
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
		openButton.setTitle("OPEN", for: .normal)
		openButton.addTarget(self, action: #selector(DesignViewController.openButtonClicked(_:)), for: .touchUpInside)
		self.view.addSubview(openButton)
		self.initLayout()
		let g = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
		self.view.addGestureRecognizer(g)
		self.addNavButtons()
	}
	
	private func addNavButtons(){
		self.config = ConfigView(frame: CGRect.init(x: 0, y: 0, width: 240.0, height: 40.0))
		self.config?.delegate = self
		let rightBarButton = UIBarButtonItem(customView: self.config!)
		self.navigationItem.rightBarButtonItem = rightBarButton
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
		store.subscribe(self.state1Subscriber) { state in
			state.select { state in state.selectedTabState }
				.skipRepeats({(lhs:Int, rhs:Int) -> Bool in
					return lhs == rhs
				})
		}
		store.subscribe(self.state2Subscriber) { state in
			state.select { state in state.uiState }
		}
		store.subscribe(self.state3Subscriber) { state in
			state.select { state in state.drawingConfigState }
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		//store.unsubscribe(self)
	}
	
	func newState(state: Int) {
		self.tabController.setSelected(state)
	}
	
	func newState(state: UIState) {
		self.openButton.isHidden = (state == .up)
	}
	
	func newState(state: DrawingConfigState) {
		self.config?.load(state: state)
	}
	
}

