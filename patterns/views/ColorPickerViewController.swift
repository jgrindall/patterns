
import UIKit
import ReSwift

protocol PColorPickerDelegate{
	func colorChosen(color: UIColor)
}

class ColorPickerRainbow : UIView{
	
	private var gLayer:CAGradientLayer = CAGradientLayer()
	
	override init(frame:CGRect){
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func draw(_ rect: CGRect) {
		print("draw")
		backgroundColor = .green
		self.setupGradient()
	}
	
	func setupGradient() {
		gLayer.removeFromSuperlayer()
		gLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
		gLayer.colors = [
			UIColor.red.cgColor,
			UIColor.yellow.cgColor,
			UIColor.green.cgColor,
			UIColor.blue.cgColor
		]
		gLayer.startPoint = CGPoint(x: 0, y: 0.5)
		gLayer.endPoint = CGPoint(x: 1, y: 0.5)
		
		layer.addSublayer(gLayer)
		print("gLayer", gLayer, self.frame, gLayer.frame)
	}
	
}

class ColorPickerSquare : UIView{
	
	private var saturationGradient = CAGradientLayer()
	private var brightnessGradient = CAGradientLayer()
	private var bgColor:UIColor
	
	override init(frame:CGRect){
		bgColor = .red
		super.init(frame: frame)
		self.setupGradient()
		self.backgroundColor = .red
	}
	
	public func setBg(color:UIColor){
		bgColor = color
		self.update()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func update(){
		self.backgroundColor = bgColor
	}
	
	override func draw(_ rect: CGRect) {
		print("draw")
		self.setupGradient()
	}
	
	func setupGradient() {
		saturationGradient.removeFromSuperlayer()
		brightnessGradient.removeFromSuperlayer()
		saturationGradient = gradientLayerWithEndPoints(CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5), endColor: .white)
		brightnessGradient = gradientLayerWithEndPoints(CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1), endColor: .black)
		layer.addSublayer(saturationGradient)
		layer.addSublayer(brightnessGradient)
	}
	
	private func gradientLayerWithEndPoints(_ start: CGPoint, _ end: CGPoint, endColor: UIColor) -> CAGradientLayer {
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = self.bounds
		gradientLayer.colors = [UIColor.clear.cgColor, endColor.cgColor]
		gradientLayer.startPoint = start
		gradientLayer.endPoint = end
		return gradientLayer
	}
}

class ColorPickerViewController:UIViewController{
	
	private var textField:UILabel = UILabel(frame: CGRect())
	private var okButton:UIButton = UIButton(type: UIButtonType.system)
	private var colorSqr:ColorPickerSquare = ColorPickerSquare(frame: CGRect())
	private var colorRainbow:ColorPickerRainbow = ColorPickerRainbow(frame: CGRect())
	private var colorSlider:UIView = UIView()
	private var rainbowSlider:UIView = UIView()
	private var rainbowConstraints:[NSLayoutConstraint] = []
	private var colorSliderConstraints:[NSLayoutConstraint] = []
	private var rainbowSliderConstraints:[NSLayoutConstraint] = []
	private var okConstraints:[NSLayoutConstraint] = []
	private var swatchConstraints:[NSLayoutConstraint] = []
	private var sqrConstraints:[NSLayoutConstraint] = []
	private var swatch:UIView = UIView()
	private var dragging:String = ""
	private var openButtonImg:UIImageView = UIImageView(image: UIImage(named: "tick2.png"))
	
	var delegate : PColorPickerDelegate?
	
	override func viewDidLoad() {
		self.view.backgroundColor = UIColor.orange
		okButton.setTitle("Ok", for: UIControlState.normal)
		okButton.setUpRoundButton(openButtonImg)
		
		textField.backgroundColor = UIColor.white
		textField.font = UIFont(name: "Verdana", size: 18)
		okButton.addTarget(self, action: #selector(ColorPickerViewController.buttonClicked(_:)), for: .touchUpInside)
		colorSlider = UIView()
		colorSlider.setUpRoundButton(nil, Constants.SIZE.COLOR_SLIDER_SIZE/2.0, UIColor.white.withAlphaComponent(0.6), UIColor.black, 2.0)
		colorSlider.alpha = 0.5
		colorSlider.isUserInteractionEnabled = false
		
		rainbowSlider = UIView()
		colorSlider.setUpRoundButton(nil, Constants.SIZE.COLOR_SLIDER_SIZE/2.0, UIColor.white.withAlphaComponent(0.6), UIColor.black, 2.0)
		rainbowSlider.alpha = 0.5
		rainbowSlider.isUserInteractionEnabled = false
		
		self.view.addSubview(textField)
		self.view.addSubview(okButton)
		self.view.addSubview(colorSqr)
		self.view.addSubview(colorRainbow)
		self.view.addSubview(swatch)
		self.view.addSubview(colorSlider)
		self.view.addSubview(rainbowSlider)
		self.swatch.backgroundColor = .green
		self.initGestures();
		self.initLayout()
	}
	
	private func initGestures(){
		let colorRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(ColorPickerViewController.detectColorPan(_:)))
		self.colorSqr.addGestureRecognizer(colorRecognizer)
		let rainbowRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer(target:self, action:#selector(ColorPickerViewController.detectRainbowPan(_:)))
		self.colorRainbow.addGestureRecognizer(rainbowRecognizer)
	}
	
	private func initLayout(){
		self.colorSliderConstraints = LayoutUtils.layoutExact(v: colorSlider, parent: self.view, x: Constants.SIZE.COLOR_PADDING, y: Constants.SIZE.COLOR_PADDING, width: Constants.SIZE.COLOR_SLIDER_SIZE, height: Constants.SIZE.COLOR_SLIDER_SIZE)
		self.swatchConstraints = LayoutUtils.layoutExact(v: swatch, parent: self.view, x: 2*Constants.SIZE.COLOR_PADDING + Constants.SIZE.COLOR_SWATCH_SIZE, y: 10, width: Constants.SIZE.COLOR_SWATCH_SIZE, height: Constants.SIZE.COLOR_SWATCH_SIZE)
		self.sqrConstraints = LayoutUtils.layoutExact(v: colorSqr, parent: self.view, x: Constants.SIZE.COLOR_PADDING, y: Constants.SIZE.COLOR_PADDING, width: Constants.SIZE.COLOR_SWATCH_SIZE, height: Constants.SIZE.COLOR_SWATCH_SIZE)
		self.rainbowConstraints = LayoutUtils.layoutExact(v: colorRainbow, parent: self.view, x: Constants.SIZE.COLOR_PADDING, y: 2*Constants.SIZE.COLOR_PADDING + Constants.SIZE.COLOR_SWATCH_SIZE, width: Constants.SIZE.COLOR_PADDING + 2*Constants.SIZE.COLOR_SWATCH_SIZE, height: 40)
		self.rainbowSliderConstraints = LayoutUtils.layoutExact(v: rainbowSlider, parent: self.view, x: 10, y: 250, width: Constants.SIZE.COLOR_SLIDER_SIZE, height: Constants.SIZE.COLOR_SLIDER_SIZE)
		self.okConstraints = LayoutUtils.layoutExact(v: okButton, parent: self.view, x: 200, y: 290, width: Constants.SIZE.BUTTON_HEIGHT, height: Constants.SIZE.BUTTON_HEIGHT)
		
		setupC(
			children: [
				colorSlider,
				swatch,
				colorSqr,
				colorRainbow,
				rainbowSlider,
				okButton
			],
			constraints: [
				colorSliderConstraints,
				swatchConstraints,
				sqrConstraints,
				rainbowConstraints,
				rainbowSliderConstraints,
				okConstraints
			],
			parent: self.view
		)
	}
	
	private func posColorSlider(_ t:CGPoint){
		positionTopLeft(colorSlider,
			max(0.0, min(t.y, Constants.SIZE.COLOR_SWATCH_SIZE)),
			max(0.0, min(t.x, Constants.SIZE.COLOR_SWATCH_SIZE))
		)
	}
	
	private func posRainbowSlider(_ t:CGPoint){
		positionTopLeft(rainbowSlider,
			max(0.0, min(t.y, Constants.SIZE.COLOR_SWATCH_SIZE)),
			max(0.0, min(t.x, Constants.SIZE.COLOR_SWATCH_SIZE))
		)
	}
	
	private func updateSwatch(){
		let hue:CGColor = self.colorRainbow.layer.colorOfPoint(point: CGPoint(x: self.rainbowSlider.frame.minX - self.colorRainbow.frame.minX, y: self.rainbowSlider.frame.minY - self.colorRainbow.frame.minY))
		swatch.backgroundColor = UIColor(cgColor: hue)
		colorSqr.backgroundColor = UIColor(cgColor: hue)
	}

	@objc func detectColorPan(_ sender:UIPanGestureRecognizer) {
		let pos:CGPoint = sender.location(in: self.view)
		print("c", pos)
		if(sender.state == .began && abs(pos.x - colorSlider.frame.minX) < 50 && abs(pos.y - colorSlider.frame.minY) < 50){
			dragging = "color"
			posColorSlider(pos)
		}
		else if(sender.state == .changed && dragging == "color"){
			posColorSlider(pos)
			updateSwatch()
		}
		else if(sender.state == .ended && dragging == "color"){
			posColorSlider(pos)
			updateSwatch()
		}
	}
	
	@objc func detectRainbowPan(_ sender:UIPanGestureRecognizer) {
		let pos:CGPoint = sender.location(in: self.view)
		print("R", pos, sender.state, rainbowSlider.frame)
		if(sender.state == .began && abs(pos.x - rainbowSlider.frame.minX) < 50 && abs(pos.y - rainbowSlider.frame.minY) < 50){
			dragging = "rainbow"
			posRainbowSlider(pos)
		}
		else if(sender.state == .changed && dragging == "rainbow"){
			posRainbowSlider(pos)
			updateSwatch()
		}
		else if(sender.state == .ended && dragging == "rainbow"){
			updateSwatch()
		}
	}
	
	@objc func buttonClicked(_ sender: AnyObject?){
		if (self.delegate) != nil{
			delegate?.colorChosen(color: swatch.backgroundColor!)
		}
		self.dismiss(animated: false, completion: nil)
	}
	
}
