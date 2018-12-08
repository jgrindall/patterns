
import UIKit
import RSClipperWrapper
import ReSwift
import EFColorPicker

class DesignViewController: UIViewController, StoreSubscriber, PPageViewController, EFColorSelectionViewControllerDelegate, UIPopoverPresentationControllerDelegate {
	
	private var drawingController:DrawingViewController
	private var drawingConstraints:[NSLayoutConstraint] = []
	private var textEntryController:TextEntryController
	private var tabController:TabController
	private var tabConstraints:[NSLayoutConstraint] = []
	private var openButton:UIButton = UIButton(frame: CGRect())
	private var openConstraints:[NSLayoutConstraint] = []
	private var button3:UIButton?
	
	required init(){
		self.tabController = TabController()
		self.drawingController = DrawingViewController()
		self.textEntryController = TextEntryController()
		super.init(nibName: nil, bundle: nil)
		self.title = "Edit your file"
	}
	
	func colorViewController(colorViewCntroller: EFColorSelectionViewController, didChangeColor color: UIColor) {
		self.view.backgroundColor = color
		print("New color: " + color.debugDescription)
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
		let viewFN = UIView(frame: CGRect.init(x: 0, y: 0, width: 180, height: 40))
		viewFN.backgroundColor = .yellow
		let button1 = UIButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 20))
		button1.setImage(UIImage(named: "notification"), for: .normal)
		button1.setTitle("one", for: .normal)
		
		button1.addTarget(self, action: #selector(DesignViewController.didTapOnRightButton), for: .touchUpInside)
		let button2 = UIButton(frame: CGRect.init(x: 40, y: 8, width: 60, height: 20))
		button2.setImage(UIImage(named: "notification"), for: .normal)
		button2.setTitle("tow", for: .normal)
		button3 = UIButton(frame: CGRect.init(x: 80, y: 8, width: 60, height: 20))
		button3?.setImage(UIImage(named: "notification"), for: .normal)
		button3?.setTitle("three", for: .normal)
		
		button3?.addTarget(self, action: #selector(DesignViewController.didTapOnRightButton), for: .touchUpInside)
		
		viewFN.addSubview(button1)
		viewFN.addSubview(button2)
		viewFN.addSubview(button3!)
		
		let rightBarButton = UIBarButtonItem(customView: viewFN)
		self.navigationItem.rightBarButtonItem = rightBarButton
	}
	
	@objc func didOk(_ sender:UITapGestureRecognizer){
		print("ok")
	}
	
	@objc func didTapOnRightButton(_ sender:UITapGestureRecognizer){
		
		let colorSelectionController = EFColorSelectionViewController()
		let navCtrl = UINavigationController(rootViewController: colorSelectionController)
		navCtrl.navigationBar.backgroundColor = UIColor.white
		navCtrl.navigationBar.isTranslucent = false
		navCtrl.modalPresentationStyle = UIModalPresentationStyle.popover
		navCtrl.popoverPresentationController?.delegate = self
		navCtrl.popoverPresentationController?.sourceView = button3
		navCtrl.popoverPresentationController?.sourceRect = (button3?.bounds)!
		navCtrl.preferredContentSize = colorSelectionController.view.systemLayoutSizeFitting(
			UILayoutFittingCompressedSize
		)
		let doneBtn: UIBarButtonItem = UIBarButtonItem(
			title: "Done",
			style: UIBarButtonItemStyle.done,
			target: self,
			action: #selector(DesignViewController.didOk)
		)
		colorSelectionController.isColorTextFieldHidden = false
		colorSelectionController.navigationItem.rightBarButtonItem = doneBtn
		colorSelectionController.delegate = self
		colorSelectionController.color = self.view.backgroundColor ?? UIColor.white
		self.present(navCtrl, animated: true, completion: nil)
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

