
import UIKit
import ReSwift

protocol PEditNameDelegate{
	func nameChosen(name: String)
}

class EditNameViewController:UIViewController{
	
	private var textField:UITextField = UITextField(frame: CGRect())
	private  var okButton:UIButton = UIButton(type: UIButtonType.system)
	private var textConstraints:[NSLayoutConstraint] = []
	private var text:String
	var delegate : PEditNameDelegate?
	
	init(_ _text: String){
		self.text = _text
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.orange
		okButton.frame = CGRect(x: 0, y: 250, width: 250, height: 20)
		okButton.setTitle("Ok", for: UIControlState.normal)
		textField.backgroundColor = UIColor.white
		textField.font = UIFont(name: "Verdana", size: 18)
		textField.text = text
		self.view.addSubview(textField)
		self.view.addSubview(okButton)
		okButton.addTarget(self, action: #selector(EditNameViewController.buttonClicked(_:)), for: .touchUpInside)
		self.initLayout()
		textField.becomeFirstResponder()
	}
	
	private func initLayout(){
		let PADDING:CGFloat = 10.0
		textConstraints = LayoutUtils.layoutExact(v: textField, parent: self.view, x: PADDING, y: PADDING, width: 200, height: 200)
		setupC(
			children: [
				textField
			],
			constraints: [
				textConstraints
			],
			parent: self.view
		)
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		if (self.delegate) != nil{
			delegate?.nameChosen(name: textField.text!)
		}
		self.dismiss(animated: false, completion: nil)
	}
	
}
