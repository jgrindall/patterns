
import UIKit
import RSClipperWrapper
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
		let height:CGFloat = self.view.frame.height
		self.view.constraints[2].constant = height + Constants.SIZE.BUTTON_HEIGHT
		UIView.animate(withDuration: Constants.ANIM.ANIM_TIME, animations: {
			self.view.layoutIfNeeded()
		}, completion: nil)
	}
	
	private func up(){
		self.view.constraints[2].constant = Constants.SIZE.BUTTON_HEIGHT
		UIView.animate(withDuration: Constants.ANIM.ANIM_TIME, animations: {
			self.view.layoutIfNeeded()
		}, completion: nil)
	}
	
	func initLayout(){
		tabContentConstraints = LayoutUtils.layoutToTopWithMargin(v: self.tabContentController.view, parent: self.view, margin: 60)
		tabButtonsConstraints = LayoutUtils.layoutAboveWithHeight(v: self.tabButtonsController.view, viewToBeAbove: self.tabContentController.view, height: 60)
		
		self.tabContentController.view.translatesAutoresizingMaskIntoConstraints = false
		self.tabButtonsController.view.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate(tabContentConstraints)
		NSLayoutConstraint.activate(tabButtonsConstraints)
		
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
		if(state == .down){
			self.down()
		}
		else{
			self.up()
		}
	}
	
}

