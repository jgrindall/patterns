
import UIKit
import ReSwift

protocol PForegroundConfigDelegate{
	func dataChosen(data: CGFloat)
}

class ForegroundConfigController:UIViewController, PColorPickerDelegate{
	
	private var button1:UIButton = UIButton(frame: CGRect())
	private var button1Con:[NSLayoutConstraint] = []
	
	private var button2:UIButton = UIButton(frame: CGRect())
	private var button2Marker:UIView = UIView(frame:CGRect())
	private var button2Con:[NSLayoutConstraint] = []
	private var button2MCon:[NSLayoutConstraint] = []
	
	private var stepper1:UIStepper = UIStepper(frame: CGRect())
	private var stepper1Con:[NSLayoutConstraint] = []
	
	private var stepper2:UIStepper = UIStepper(frame: CGRect())
	private var stepper2Con:[NSLayoutConstraint] = []
	
	private var swatch:MarkerView = MarkerView(frame: CGRect())
	private var swatchCon:[NSLayoutConstraint] = []
	
	private  var okButton:UIButton = UIButton(type: UIButtonType.system)
	private var okConstraints:[NSLayoutConstraint] = []
	private var editedColor:String = "";
	
	var delegate : PForegroundConfigDelegate?
	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.orange
		okButton.frame = CGRect(x: 0, y: 250, width: 250, height: 20)
		okButton.setTitle("Ok", for: UIControlState.normal)
		self.view.addSubview(okButton)
		okButton.addTarget(self, action: #selector(ForegroundConfigController.okClicked(_:)), for: .touchUpInside)
		okButton.setUpRoundButton(nil, 4.0, .clear, UIColor.black, 1.0)
		
		button1.setUpRoundButton(nil, 4.0, .clear, UIColor.black, 1.0)
		button2.setUpRoundButton(nil, 4.0, .clear, UIColor.black, 1.0)
		
		self.view.addSubview(button1)
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
		
		stepper1.tintColor = UIColor.red
		stepper1.tintColor = UIColor.black
		
		
		self.initLayout()
	}
	
	func colorChosen(color: UIColor) {
		print(color, editedColor)
		swatch.update(bg: .red, fg: .green, width: 30)
		if(editedColor == "2"){
			self.button2.backgroundColor = color
		}
		else{
			self.button1.backgroundColor = color
		}
	}
	
	private func initLayout(){
		self.button1Con = LayoutUtils.layoutExact(v: button1, parent: self.view, x: Constants.SIZE.COLOR_PADDING, y: Constants.SIZE.COLOR_PADDING, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		self.button2Con = LayoutUtils.layoutExact(v: button2, parent: self.view, x: Constants.SIZE.CONFIG_MARKER_SIZE + 2*Constants.SIZE.COLOR_PADDING, y: Constants.SIZE.COLOR_PADDING, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		self.stepper1Con = LayoutUtils.layoutExact(v: stepper1, parent: self.view, x: Constants.SIZE.COLOR_PADDING, y: Constants.SIZE.CONFIG_MARKER_SIZE + 2*Constants.SIZE.COLOR_PADDING, width: 200, height: 50)
		self.stepper2Con = LayoutUtils.layoutExact(v: stepper2, parent: self.view, x: Constants.SIZE.COLOR_PADDING, y: 2*Constants.SIZE.CONFIG_MARKER_SIZE + 3*Constants.SIZE.COLOR_PADDING, width: 200, height: 50)
		self.swatchCon = LayoutUtils.layoutExact(v: swatch, parent: self.view, x: 200, y: 100, width: Constants.SIZE.COLOR_SWATCH_SIZE, height: Constants.SIZE.COLOR_SWATCH_SIZE)
		self.okConstraints = LayoutUtils.layoutExact(v: okButton, parent: self.view, x: 400, y: 490, width: Constants.SIZE.BUTTON_HEIGHT, height: Constants.SIZE.BUTTON_HEIGHT)
		
		setupC(
			children: [
				self.button1,
				self.button2,
				stepper1,
				stepper2,
				swatch,
				okButton
			],
			constraints: [
				button1Con,
				button2Con,
				stepper1Con,
				stepper2Con,
				swatchCon,
				okConstraints
			],
			parent: self.view
		)
	}
	
	func openEditor(){
		let editor:ColorPickerViewController = ColorPickerViewController()
		editor.delegate = self
		editor.preferredContentSize = CGSize(width: Constants.SIZE.COLOR_SWATCH_SIZE*2.0 + Constants.SIZE.COLOR_PADDING*3.0, height: 350)
		editor.modalPresentationStyle = .popover
		let popover = editor.popoverPresentationController
		popover?.sourceView = self.view
		popover?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
		popover?.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
		self.present(editor, animated: true, completion: nil)
	}
	
	@objc func button1Clicked(_ sender: AnyObject?){
		self.editedColor = "1"
		self.openEditor()
	}
	
	@objc func button2Clicked(_ sender: AnyObject?){
		self.editedColor = "2"
		self.openEditor()
	}
	
	@objc func okClicked(_ sender: AnyObject?){
		
	}
	
}

