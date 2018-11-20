
import UIKit
import ReSwift

protocol PEditorControllerDelegate{
	func updateData(index:Int, model: DragItemModel)
}

class EditorViewController:UIViewController{
	
	private var textField:UITextField = UITextField(frame: CGRect(x: 20, y: 20, width: 250, height: 150))
	private  var okButton:UIButton = UIButton(type: UIButtonType.system)
	var delegate : PEditorControllerDelegate?
	private var index:Int = 0
	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.orange
		okButton.frame = CGRect(x: 0, y: 250, width: 250, height: 20)
		okButton.setTitle("Ok", for: UIControlState.normal)
		textField.backgroundColor = UIColor.white
		textField.minimumFontSize = 32.0
		textField.font = UIFont(name: "Verdana", size: 18)
		self.view.addSubview(textField)
		self.view.addSubview(okButton)
		okButton.addTarget(self, action: #selector(TextEntryController.buttonClicked(_:)), for: .touchUpInside)
		textField.addTarget(self, action: #selector(TextEntryController.textChanged(_:)), for: .editingChanged)
	}
	
	func loadData(_ index:Int, _ data:DragItemModel){
		self.textField.text = data.label
		self.index = index
	}
	
	@objc func textChanged(_ sender: AnyObject?){
		//
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		if (self.delegate) != nil{
			delegate?.updateData(index:self.index, model: DragItemModel(type: "FD", content:"2", label: "FD3245", imageSrc: ""))
		}
		self.dismiss(animated: false, completion: nil)
	}
	
}
