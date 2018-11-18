
import UIKit
import RSClipperWrapper
import ReSwift

class TabButtonsController: UIViewController, StoreSubscriber {
	
	private var buttons:[UIButton] = []
	private var buttonConstraints:[ [NSLayoutConstraint] ] = []
	
	private var addButton:UIButton = UIButton(frame: CGRect())
	private var addConstraints:[NSLayoutConstraint] = []
	
	required init(){
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(addButton)
		addButton.translatesAutoresizingMaskIntoConstraints = false
		addButton.setImage(UIImage(named: "add.png"), for: .normal)
		self.view.backgroundColor = UIColor.magenta
		addConstraints = LayoutUtils.centreRight(v: addButton, parent: self.view, margin: 10, width: 60, height: 60)
		NSLayoutConstraint.activate(addConstraints)
		addButton.addTarget(self, action: #selector(TabButtonsController.addButtonClicked(_:)), for: .touchUpInside)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.tabs
			}
			.skipRepeats()
		}
	}
	
	public func setSelected(_ index:Int){
		for i in 0..<self.buttons.count{
			let isSelected:Bool = (i == index)
			self.buttons[i].isSelected = isSelected
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	private func removeLayout(){
		for i in 0..<self.buttonConstraints.count{
			NSLayoutConstraint.deactivate(self.buttonConstraints[i])
		}
		self.buttonConstraints = []
	}
	
	private func removeContent(){
		for i in 0..<self.buttons.count{
			self.buttons[i].removeTarget(self, action: #selector(TabButtonsController.buttonClicked(_:)), for: .touchUpInside)
			self.buttons[i].removeFromSuperview();
		}
		self.buttons = []
	}
	
	public func addButtons(_ names:[String]){
		for i in 0..<names.count{
			let b:UIButton = self.getButton(index:i, label:names[i])
			self.buttons.append(b)
			self.view.addSubview(b)
		}
	}
	
	private func getButton(index:Int, label:String) -> UIButton{
		let b:UIButton = UIButton(frame:CGRect())
		b.setTitle(label, for: .normal)
		b.addTarget(self, action: #selector(TabButtonsController.buttonClicked(_:)), for: .touchUpInside)
		b.backgroundColor = .gray
		b.setBackgroundColor(color: .green, forState: UIControlState.selected)
		b.translatesAutoresizingMaskIntoConstraints = false
		return b
	}
	
	private func initLayout(){
		self.removeLayout()
		for i in 0..<self.buttons.count{
			let constraints:[NSLayoutConstraint] = LayoutUtils.absolute(v: self.buttons[i], parent: self.view, rect:CGRect(x: CGFloat(i)*Constants.SIZE.BUTTON_WIDTH, y: 0, width: Constants.SIZE.BUTTON_WIDTH, height: Constants.SIZE.BUTTON_HEIGHT))
			self.buttonConstraints.append(constraints)
			NSLayoutConstraint.activate(constraints)
		}
	}
	
	@objc func addButtonClicked(_ sender: AnyObject?){
		let numButtons:Int = store.state.tabs.names.count
		store.dispatch(AddTabAction())
		store.dispatch(AddFlowAction())
		store.dispatch(SetSelectedTabAction(payload: numButtons))
		//store.dispatch(SetItemsAction(payload: store.state.
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		if let button:UIButton = sender as? UIButton {
			if(!button.isSelected){
				store.dispatch(SetSelectedTabAction(payload: self.buttons.index(of: button)!))
			}
		}
	}
	
	func newState(state: TabsState) {
		self.removeContent()
		self.addButtons(state.names)
		self.initLayout()
		self.setSelected(store.state.selectedTabState)
	}

}

