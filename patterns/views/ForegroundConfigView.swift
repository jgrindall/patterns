
import UIKit
import ReSwift

protocol PForegroundConfigDelegate{
	func dataChosen(data: CGFloat)
}

class ForegroundConfigController:UIViewController, PColorPickerDelegate{
	
	private var button1:UIButton = UIButton(frame: CGRect())
	private var button1Marker:UIView = UIView(frame:CGRect())
	private var button1Con:[NSLayoutConstraint] = []
	private var button1MCon:[NSLayoutConstraint] = []
	
	private var button2:UIButton = UIButton(frame: CGRect())
	private var button2Marker:UIView = UIView(frame:CGRect())
	private var button2Con:[NSLayoutConstraint] = []
	private var button2MCon:[NSLayoutConstraint] = []
	
	private var stepper1:UIStepper = UIStepper(frame: CGRect())
	private var stepper1Con:[NSLayoutConstraint] = []
	
	private var stepper2:UIStepper = UIStepper(frame: CGRect())
	private var stepper2Con:[NSLayoutConstraint] = []
	
	private var swatch:UIView = UIView(frame: CGRect())
	private var swatchCon:[NSLayoutConstraint] = []
	
	private  var okButton:UIButton = UIButton(type: UIButtonType.system)
	var delegate : PForegroundConfigDelegate?
	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.orange
		okButton.frame = CGRect(x: 0, y: 250, width: 250, height: 20)
		okButton.setTitle("Ok", for: UIControlState.normal)
		self.view.addSubview(okButton)
		okButton.addTarget(self, action: #selector(ForegroundConfigController.okClicked(_:)), for: .touchUpInside)
		
		button1.setImage(UIImage(named: "notification"), for: .normal)
		button1.setTitle("1", for: .normal)
		self.view.addSubview(button1)
		button1.addSubview(button1Marker)
		button1Marker.isUserInteractionEnabled = false
		
		button2.setImage(UIImage(named: "notification"), for: .normal)
		button2.setTitle("1", for: .normal)
		self.view.addSubview(button2)
		button2.addSubview(button2Marker)
		button2Marker.isUserInteractionEnabled = false
		
		button1.addTarget(self, action: #selector(ForegroundConfigController.button1Clicked(_:)), for: .touchUpInside)
		button2.addTarget(self, action: #selector(ForegroundConfigController.button2Clicked(_:)), for: .touchUpInside)
		
		stepper1.minimumValue = 0
		stepper1.maximumValue = 20
		self.view.addSubview(stepper1)
		
		stepper2.minimumValue = 0
		stepper2.maximumValue = 20
		self.view.addSubview(stepper2)
		
		self.view.addSubview(swatch)
		self.swatch.backgroundColor = .red
		
		self.initLayout()
	}
	
	func colorChosen(color: UIColor) {
		print(color)
	}
	
	private func initLayout(){
		self.button1Con = LayoutUtils.layoutExact(v: button1, parent: self.view, x: 0, y: 0, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		self.button2Con = LayoutUtils.layoutExact(v: button2, parent: self.view, x: 0, y: 100, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		self.stepper1Con = LayoutUtils.layoutExact(v: stepper1, parent: self.view, x: 0, y: 200, width: 200, height: 50)
		self.stepper2Con = LayoutUtils.layoutExact(v: stepper2, parent: self.view, x: 0, y: 300, width: 200, height: 50)
		self.swatchCon = LayoutUtils.layoutExact(v: swatch, parent: self.view, x: 400, y: 100, width: 150, height: 150)
		setupC(
			children: [
				self.button1,
				self.button2,
				stepper1,
				stepper2,
				swatch
			],
			constraints: [
				button1Con,
				button2Con,
				stepper1Con,
				stepper2Con,
				swatchCon
			],
			parent: self.view
		)
	}
	
	@objc func button1Clicked(_ sender: AnyObject?){
		let editor:ColorPickerViewController = ColorPickerViewController()
		editor.delegate = self
		editor.preferredContentSize = CGSize(width: Constants.SIZE.COLOR_SWATCH_SIZE*2.0, height: 350)
		editor.modalPresentationStyle = .popover
		let popover = editor.popoverPresentationController
		popover?.sourceView = self.view
		popover?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
		popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
		self.present(editor, animated: true, completion: nil)
	}
	
	@objc func button2Clicked(_ sender: AnyObject?){
		
	}
	
	@objc func okClicked(_ sender: AnyObject?){
		
	}
	
}

