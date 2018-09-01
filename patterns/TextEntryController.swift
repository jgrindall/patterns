
import UIKit
import ReSwift

class TextEntryController: UIViewController, StoreSubscriber {
	
	typealias StoreSubscriberStateType = AppState
	
	var textField:UITextField = UITextField(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
	var okButton:UIButton = UIButton(type: UIButtonType.system)

	override func viewDidLoad() {
		super.viewDidLoad()
		okButton.frame = CGRect(x: 0, y: 250, width: 250, height: 20)
		okButton.setTitle("Ok", for: UIControlState.normal)
		textField.backgroundColor = UIColor.blue
		textField.minimumFontSize = 32.0
		textField.font = UIFont(name: "Verdana", size: 24)
		self.view.addSubview(textField)
		self.view.addSubview(okButton)
		okButton.addTarget(self, action: #selector(TextEntryController.buttonClicked(_:)), for: .touchUpInside)
		textField.addTarget(self, action: #selector(TextEntryController.textChanged(_:)), for: .editingChanged)
	}
	
	func newState(state: AppState) {
		print("new state", state)
		textField.text = state.text
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	@objc func textChanged(_ sender: AnyObject?){
		store.dispatch(EditTextAction(payload: textField.text!))
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		print("click")
		store.dispatch(StatusActionStart())
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}


}

