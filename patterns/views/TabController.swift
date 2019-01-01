
import UIKit
import ReSwift

class TabController: UIViewController, StoreSubscriber {
	
	private var tabButtonsController:TabButtonsController
	private var tabButtonsConstraints:[NSLayoutConstraint] = []
	private var tabContentController:TabContentController
	private var tabContentConstraints:[NSLayoutConstraint] = []
	
	required init(){
		self.tabButtonsController = TabButtonsController()
		self.tabContentController = TabContentController()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		displayContentController(container: self, content: tabButtonsController)
		displayContentController(container: self, content: tabContentController)
		self.initLayout()
	}
	
	private func down(){
		animateBottom(self.view, self.view.frame.height + Constants.SIZE.BUTTON_HEIGHT)
	}
	
	private func up(){
		animateBottom(self.view, Constants.SIZE.BUTTON_HEIGHT)
	}
	
	func initLayout(){
		tabContentConstraints = LayoutUtils.layoutToTopWithMargin(v: self.tabContentController.view, parent: self.view, margin: 60)
		tabButtonsConstraints = LayoutUtils.layoutToTopWithHeight(v: self.tabButtonsController.view, parent: self.view, height: 60)
		setupC(
			children: [
				tabContentController.view,
				tabButtonsController.view
			],
			constraints: [
				tabContentConstraints,
				tabButtonsConstraints
			],
			parent: self.view
		)
	}
	
	public func setSelected(_ i:Int){
		tabButtonsController.setSelected(i)
		tabContentController.setSelected(i)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.uiState
				}
				.skipRepeats()
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: UIState) {
		if(state.tabs == .hide){
			self.down()
		}
		else{
			self.up()
		}
	}
	
}

