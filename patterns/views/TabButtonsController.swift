
import UIKit
import RSClipperWrapper
import ReSwift

class TabButtonsController: UIViewController, StoreSubscriber {
	
	private var buttons:[UIButton] = []
	
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
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	private func remove(){
		for i in 0..<self.buttons.count{
			self.buttons[i].removeTarget(self, action: #selector(TabButtonsController.buttonClicked(_:)), for: .touchUpInside)
			self.buttons[i].removeFromSuperview();
		}
		self.buttons = []
	}
	
	public func addButtons(_ names:[String]){
		print("SET TAVS", names)
		for i in 0..<names.count{
			let b:UIButton = self.getButton(i)
			self.buttons.append(b)
			self.view.addSubview(b)
		}
	}
	
	private func getButton(_ i:Int) -> UIButton{
		let b:UIButton = UIButton(frame:CGRect(x: i*200, y: 0, width: 80, height: 30))
		b.setTitle("Page " + String(i), for: .normal)
		b.addTarget(self, action: #selector(TabButtonsController.buttonClicked(_:)), for: .touchUpInside)
		b.backgroundColor = .green
		return b
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		print("click button")
	}
	
	func newState(state: TabsState) {
		print("newtabsstate", state)
		self.remove()
		self.addButtons(state.names)
	}

}

