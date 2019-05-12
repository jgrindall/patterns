
import UIKit
import ReSwift

class DesignViewController: UIViewController, PPageViewController, PColorPickerDelegate, UIPopoverPresentationControllerDelegate {
	
	private var drawingController:DrawingViewController
	private var drawingConstraints:[NSLayoutConstraint] = []
	private var symmPathController:SymmPathViewController
	private var symmPathConstraints:[NSLayoutConstraint] = []
	private var symmController:SymmController
	private var symmConstraints:[NSLayoutConstraint] = []
	private var openButton:UIButton = UIButton(frame: CGRect())
	private var openButtonImg:UIImageView = UIImageView(image: UIImage(named: "tick2.png"))
	private var openConstraints:[NSLayoutConstraint] = []
	private var selectedColor:UIColor?
	private var config:ConfigView?
	private var input:String = ""
	
	private lazy var state2Subscriber: BlockSubscriber<UIState> = BlockSubscriber(block: {state in
		self.newState(state: state)
	})
	
	required init(){
		self.drawingController = DrawingViewController()
		self.symmPathController = SymmPathViewController()
		self.symmController = SymmController()
		super.init(nibName: nil, bundle: nil)
		self.title = "Edit your file"
	}
	
	func dataChosen(data: CGFloat) {
		print(data)
	}
	
	func colorChosen(color: UIColor) {
		//store.dispatch(SetBgStateAction(payload: color))
	}
	
	func didReceiveConfig(input: String){
		self.input = input
		store.dispatch(SetUISymmStateAction(payload: (store.state.uiState.symm == .show ? .hide : .show)))
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
		print("symm disp")
		displayContentController(container: self, content: drawingController)
		displayContentController(container: self, content: symmPathController)
		displayContentController(container: self, content: symmController)
		openButton.setUpRoundButton(openButtonImg)
		//openButton.addTarget(self, action: #selector(DesignViewController.openButtonClicked(_:)), for: .touchUpInside)
		self.view.addSubview(openButton)
		let g = UITapGestureRecognizer(target: self, action:  #selector (self.someAction (_:)))
		self.view.addGestureRecognizer(g)
		self.addNavButtons()
	}
	
	private func addNavButtons(){
		//self.config = ConfigView(frame: CGRect.init(x: 0, y: 0, width: 3*Constants.SIZE.CONFIG_MARKER_SIZE + 2*Constants.SIZE.CONFIG_MARKER_PADDING, height: Constants.SIZE.CONFIG_MARKER_SIZE))
		//self.config?.delegate = self
		//let rightBarButton = UIBarButtonItem(customView: self.config!)
		//self.navigationItem.rightBarButtonItem = rightBarButton
	}
	
	@objc func someAction(_ sender:UITapGestureRecognizer){
		store.dispatch(SetUISymmStateAction(payload: .hide))
	}
	
	func initLayout(){
		drawingConstraints = LayoutUtils.layoutFull(v: self.drawingController.view, parent: self.view)
		symmPathConstraints = LayoutUtils.layoutFull(v: self.symmPathController.view, parent: self.view)
		openConstraints = LayoutUtils.bottomRight(v: self.openButton, parent: self.view, margin: 0, width: Constants.SIZE.BUTTON_HEIGHT, height: Constants.SIZE.BUTTON_HEIGHT)
		symmConstraints = LayoutUtils.layoutExact(v: self.symmController.view, parent: self.view, x: self.view.frame.width - Constants.SIZE.SYMM_WIDTH, y: -self.getNavHeight() - Constants.SIZE.SYMM_HEIGHT, width: Constants.SIZE.SYMM_WIDTH, height:Constants.SIZE.SYMM_HEIGHT)
		
		setupC(
			children: [
				self.drawingController.view,
				self.symmPathController.view,
				openButton,
				self.symmController.view
			],
			constraints: [
				drawingConstraints,
				symmPathConstraints,
				openConstraints,
				symmConstraints
			],
			parent: self.view
		)
		
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.initLayout()
		store.subscribe(self.state2Subscriber) { state in
			state.select { state in state.uiState }
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self.state2Subscriber)
	}
	
	func newState(state: UIState) {
		self.symmPathController.view.isHidden = (state.symm == .hide)
		self.openButton.isHidden = (state.tabs == .show)
	}

	
}

