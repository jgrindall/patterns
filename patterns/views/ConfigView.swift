
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
	private var button3Con:[NSLayoutConstraint] = []
	
	var delegate: ConfigDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)

		button1.setImage(UIImage(named: "notification"), for: .normal)
		button1.setTitle("1", for: .normal)
		
		button2.setImage(UIImage(named: "notification"), for: .normal)
		button2.setTitle("2", for: .normal)
		
		button3.setImage(UIImage(named: "notification"), for: .normal)
		button3.setTitle("symm", for: .normal)
		
		button1.addTarget(self, action: #selector(ConfigView.didTapOnRightButton1), for: .touchUpInside)
		button2.addTarget(self, action: #selector(ConfigView.didTapOnRightButton2), for: .touchUpInside)
		button3.addTarget(self, action: #selector(ConfigView.didTapOnRightButton3), for: .touchUpInside)
		
		addSubview(button1)
		button1.addSubview(button1Marker)
		
		addSubview(button2)
		button2.addSubview(button2Marker)
		
		addSubview(button3)
		
		button1Marker.isUserInteractionEnabled = false
		button2Marker.isUserInteractionEnabled = false
		
		self.initLayout()
	}
	
	func initLayout(){
		self.button1Con = LayoutUtils.layoutExact(v: button1, parent: self, x: 0, y: 0, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		self.button2Con = LayoutUtils.layoutExact(v: button2, parent: self, x: Constants.SIZE.CONFIG_BUTTON_WIDTH, y: 0, width: Constants.SIZE.CONFIG_BUTTON_WIDTH, height: Constants.SIZE.CONFIG_BUTTON_HEIGHT)
		self.button1MCon = LayoutUtils.layoutExact(v: button1Marker, parent: button1, x: 0, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		self.button2MCon = LayoutUtils.layoutExact(v: button2Marker, parent: button2, x: 0, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		self.button3Con = LayoutUtils.layoutExact(v: button3, parent: self, x: 2*Constants.SIZE.CONFIG_BUTTON_WIDTH, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		setupC(
			children: [
				button1,
				button2,
				button1Marker,
				button2Marker,
				button3
			],
			constraints: [
				button1Con,
				button2Con,
				button1MCon,
				button2MCon,
				button3Con
			],
			parent: self
		)
	}
	
	public func load(state:DrawingConfigState){
		button1Marker.backgroundColor = state.bg
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
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


