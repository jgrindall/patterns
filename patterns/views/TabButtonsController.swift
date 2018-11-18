
import UIKit
import RSClipperWrapper
import ReSwift

class TabButtonsController: UIViewController, StoreSubscriber {
	
	private var buttons:[UIButton] = []
	private var buttonConstraints:[ [NSLayoutConstraint] ] = []
	
	required init(){
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.magenta
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
			self.buttons[i].isEnabled = (i == index)
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
		self.setSelected(0)
	}
	
	private func getButton(index:Int, label:String) -> UIButton{
		let b:UIButton = UIButton(frame:CGRect())
		b.setTitle("Page " + label, for: .normal)
		b.addTarget(self, action: #selector(TabButtonsController.buttonClicked(_:)), for: .touchUpInside)
		b.backgroundColor = .green
		b.setBackgroundColor(color: .gray, forState: .disabled)
		b.translatesAutoresizingMaskIntoConstraints = false
		return b
	}
	
	private func initLayout(){
		self.removeLayout()
		for i in 0..<self.buttons.count{
			let constraints:[NSLayoutConstraint] = LayoutUtils.absolute(v: self.buttons[i], parent: self.view, rect:CGRect(x: i*200, y: 0, width: 80, height: 30))
			self.buttonConstraints.append(constraints)
			NSLayoutConstraint.activate(constraints)
		}
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		print("click button")
	}
	
	func newState(state: TabsState) {
		self.removeContent()
		self.addButtons(state.names)
		self.initLayout()
	}

}

