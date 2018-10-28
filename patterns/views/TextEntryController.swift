
import UIKit
import ReSwift

class TextEntryController: UIViewController, StoreSubscriber {
	
	private var textField:UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 500, height: 200))
	private var okButton:UIButton = UIButton(type: UIButtonType.system)

	override func viewDidLoad() {
		super.viewDidLoad()
		okButton.frame = CGRect(x: 0, y: 250, width: 250, height: 20)
		okButton.setTitle("Ok", for: UIControlState.normal)
		textField.backgroundColor = UIColor.blue
		textField.minimumFontSize = 32.0
		textField.font = UIFont(name: "Verdana", size: 18)
		self.view.addSubview(textField)
		self.view.addSubview(okButton)
		okButton.addTarget(self, action: #selector(TextEntryController.buttonClicked(_:)), for: .touchUpInside)
		textField.addTarget(self, action: #selector(TextEntryController.textChanged(_:)), for: .editingChanged)
	}
	
	func newState(state: String) {
		//print("new state", state)
		textField.text = state
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
				.select {
					$0.text
				}
				.skipRepeats()
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	@objc func textChanged(_ sender: AnyObject?){
		store.dispatch(EditTextAction(payload: textField.text!))
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		store.dispatch(StatusActionStart())
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}

