
import UIKit
import ReSwift

class TabButtonsController: UIViewController, StoreSubscriber, PEditNameDelegate {
	
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
		self.view.backgroundColor = Constants.COLORS.BG_COLOR
		addConstraints = LayoutUtils.centreRight(v: addButton, parent: self.view, margin: 10, width: Constants.SIZE.TAB_BUTTON_HEIGHT, height: Constants.SIZE.TAB_BUTTON_HEIGHT)
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
			let constraints:[NSLayoutConstraint] = LayoutUtils.absolute(v: self.buttons[i], parent: self.view, rect:CGRect(x: CGFloat(i)*Constants.SIZE.TAB_BUTTON_WIDTH, y: 0, width: Constants.SIZE.TAB_BUTTON_WIDTH, height: Constants.SIZE.TAB_BUTTON_HEIGHT))
			self.buttonConstraints.append(constraints)
			NSLayoutConstraint.activate(constraints)
		}
	}
	
	private func nameIsOk(_ name:String) -> Bool{
		if(name.count == 0){
			return false
		}
		if(name.count >= 11){
			return false
		}
		let names:[String] = store.state.tabs.names
		return !names.contains(name)
	}
	
	@objc func addButtonClicked(_ sender: AnyObject?){
		var name = "New tab"
		var i = 0
		while(!nameIsOk(name)){
			i = i + 1
			name = "New tab (" + String(i) + ")"
		}
		let numButtons:Int = store.state.tabs.names.count
		store.dispatch(AddTabAction(name: name))
		store.dispatch(AddFlowAction(name: name))
		store.dispatch(SetSelectedTabAction(payload: numButtons))
		_ = EditNameCommand(text:name, delegate: self, parentViewController: self)
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		if let button:UIButton = sender as? UIButton {
			if(button.isSelected){
				_ = EditNameCommand(text:store.state.getCurrentTab(), delegate: self, parentViewController: self)
			}
			else{
				store.dispatch(SetSelectedTabAction(payload: self.buttons.index(of: button)!))
			}
		}
	}
	
	func nameChosen(name: String) {
		let index:Int = store.state.selectedTabState
		if(nameIsOk(name)){
			store.dispatch(EditNameAction(index: index, newName: name))
		}
	}
	
	func newState(state: TabsState) {
		self.removeContent()
		self.addButtons(state.names)
		self.initLayout()
		self.setSelected(store.state.selectedTabState)
	}

}

