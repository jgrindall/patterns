
import UIKit
import ReSwift

protocol ConfigDelegate {
	func didReceiveConfig(input: String)
}

class ConfigView: UIView {
	
	private var button1:UIButton = UIButton(frame: CGRect())
	private var button1Marker:UIView = UIView(frame:CGRect())
	private var button1Con:[NSLayoutConstraint] = []
	private var button1MCon:[NSLayoutConstraint] = []
	
	private var button2:UIButton = UIButton(frame: CGRect())
	private var button2Marker:UIView = UIView(frame:CGRect())
	private var button2Con:[NSLayoutConstraint] = []
	private var button2MCon:[NSLayoutConstraint] = []
	
	private var button3:UIButton = UIButton(frame: CGRect())
	private var button3Marker:UIView = UIView(frame:CGRect())
	private var button3Con:[NSLayoutConstraint] = []
	private var button3MCon:[NSLayoutConstraint] = []
	
	private var button4:UIButton = UIButton(frame: CGRect())
	private var button4Marker:UIView = UIView(frame:CGRect())
	private var button4Con:[NSLayoutConstraint] = []
	private var button4MCon:[NSLayoutConstraint] = []
	
	private var button5:UIButton = UIButton(frame: CGRect())
	private var button5Marker:UIView = UIView(frame:CGRect())
	private var button5Con:[NSLayoutConstraint] = []
	private var button5MCon:[NSLayoutConstraint] = []
	
	var delegate: ConfigDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		button1.setImage(UIImage(named: "notification"), for: .normal)
		button1.setTitle("1", for: .normal)
		
		button2.setImage(UIImage(named: "notification"), for: .normal)
		button2.setTitle("2", for: .normal)
		
		button3.setImage(UIImage(named: "notification"), for: .normal)
		button3.setTitle("3", for: .normal)
		
		button4.setImage(UIImage(named: "notification"), for: .normal)
		button4.setTitle("4", for: .normal)
		
		button5.setImage(UIImage(named: "notification"), for: .normal)
		button5.setTitle("5", for: .normal)
		
		button1.addTarget(self, action: #selector(ConfigView.didTapOnRightButton1), for: .touchUpInside)
		button2.addTarget(self, action: #selector(ConfigView.didTapOnRightButton2), for: .touchUpInside)
		button3.addTarget(self, action: #selector(ConfigView.didTapOnRightButton3), for: .touchUpInside)
		button4.addTarget(self, action: #selector(ConfigView.didTapOnRightButton4), for: .touchUpInside)
		button5.addTarget(self, action: #selector(ConfigView.didTapOnRightButton5), for: .touchUpInside)
		
		addSubview(button1)
		button1.addSubview(button1Marker)
		
		addSubview(button2)
		button2.addSubview(button2Marker)
		
		addSubview(button3)
		button3.addSubview(button3Marker)
		
		addSubview(button4)
		button4.addSubview(button4Marker)
		
		addSubview(button5)
		button5.addSubview(button5Marker)
		
		button1Marker.isUserInteractionEnabled = false
		button2Marker.isUserInteractionEnabled = false
		button3Marker.isUserInteractionEnabled = false
		button4Marker.isUserInteractionEnabled = false
		button5Marker.isUserInteractionEnabled = false
	
		self.initLayout()
	}
	
	func initLayout(){
		self.button1.translatesAutoresizingMaskIntoConstraints = false
		self.button1Con = LayoutUtils.layoutExact(v: button1, parent: self, x: 0, y: 0, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		NSLayoutConstraint.activate(self.button1Con)
		self.button2.translatesAutoresizingMaskIntoConstraints = false
		self.button2Con = LayoutUtils.layoutExact(v: button2, parent: self, x: Constants.SIZE.CONFIG_BUTTON_WIDTH, y: 0, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		NSLayoutConstraint.activate(self.button2Con)
		self.button3.translatesAutoresizingMaskIntoConstraints = false
		self.button3Con = LayoutUtils.layoutExact(v: button3, parent: self, x: 2.0*Constants.SIZE.CONFIG_BUTTON_WIDTH, y: 0, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		NSLayoutConstraint.activate(self.button3Con)
		self.button4.translatesAutoresizingMaskIntoConstraints = false
		self.button4Con = LayoutUtils.layoutExact(v: button4, parent: self, x: 3.0*Constants.SIZE.CONFIG_BUTTON_WIDTH, y: 0, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		NSLayoutConstraint.activate(self.button4Con)
		self.button5.translatesAutoresizingMaskIntoConstraints = false
		self.button5Con = LayoutUtils.layoutExact(v: button5, parent: self, x: 4.0*Constants.SIZE.CONFIG_BUTTON_WIDTH, y: 0, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		NSLayoutConstraint.activate(self.button5Con)
		
		self.button1Marker.translatesAutoresizingMaskIntoConstraints = false
		self.button1MCon = LayoutUtils.layoutExact(v: button1Marker, parent: button1, x: 0, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		NSLayoutConstraint.activate(self.button1MCon)
		self.button2Marker.translatesAutoresizingMaskIntoConstraints = false
		self.button2MCon = LayoutUtils.layoutExact(v: button2Marker, parent: button2, x: 0, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		NSLayoutConstraint.activate(self.button2MCon)
		self.button3Marker.translatesAutoresizingMaskIntoConstraints = false
		self.button3MCon = LayoutUtils.layoutExact(v: button3Marker, parent: button3, x: 0, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		NSLayoutConstraint.activate(self.button3MCon)
		self.button4Marker.translatesAutoresizingMaskIntoConstraints = false
		self.button4MCon = LayoutUtils.layoutExact(v: button4Marker, parent: button4, x: 0, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		NSLayoutConstraint.activate(self.button4MCon)
		self.button5Marker.translatesAutoresizingMaskIntoConstraints = false
		self.button5MCon = LayoutUtils.layoutExact(v: button5Marker, parent: button5, x: 0, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		NSLayoutConstraint.activate(self.button5MCon)
	}
	
	public func load(state:DrawingConfigState){
		button5Marker.backgroundColor = state.bg
		button4Marker.backgroundColor = state.bg
		button3Marker.backgroundColor = state.bg
		button2Marker.backgroundColor = state.fg
	}
	
	@objc func didTapOnRightButton1(_ sender:UITapGestureRecognizer){
		self.delegate?.didReceiveConfig(input: "1")
	}
	
	@objc func didTapOnRightButton2(_ sender:UITapGestureRecognizer){
		self.delegate?.didReceiveConfig(input: "2")
	}
	
	@objc func didTapOnRightButton3(_ sender:UITapGestureRecognizer){
		self.delegate?.didReceiveConfig(input: "3")
	}
	
	@objc func didTapOnRightButton4(_ sender:UITapGestureRecognizer){
		self.delegate?.didReceiveConfig(input: "4")
	}
	
	@objc func didTapOnRightButton5(_ sender:UITapGestureRecognizer){
		self.delegate?.didReceiveConfig(input: "5")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


