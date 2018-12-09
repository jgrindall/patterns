
import UIKit
import ReSwift

protocol PLineWidthDelegate{
	func widthChosen(width: CGFloat)
}

class LineWidthViewController:UIViewController{
	
	private var textField:UILabel = UILabel(frame: CGRect())
	private  var okButton:UIButton = UIButton(type: UIButtonType.system)
	var delegate : PLineWidthDelegate?
	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.orange
		okButton.frame = CGRect(x: 0, y: 250, width: 250, height: 20)
		okButton.setTitle("Ok", for: UIControlState.normal)
		textField.backgroundColor = UIColor.white
		textField.font = UIFont(name: "Verdana", size: 18)
		self.view.addSubview(textField)
		self.view.addSubview(okButton)
		okButton.addTarget(self, action: #selector(LineWidthViewController.buttonClicked(_:)), for: .touchUpInside)
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		if (self.delegate) != nil{
			delegate?.widthChosen(width: 7.0)
		}
		self.dismiss(animated: false, completion: nil)
	}
	
}
