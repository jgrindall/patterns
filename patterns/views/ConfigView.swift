
import UIKit
import ReSwift

protocol ConfigDelegate {
	func didReceiveConfig(input: String)
}

class ConfigView: UIView {
	
	private var button3:UIButton = UIButton(frame: CGRect())
	private var button3Con:[NSLayoutConstraint] = []
	
	var delegate: ConfigDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		button3.setTitle("p3m1", for: .normal)
		button3.setUpRoundButton(nil, 4.0, .clear, UIColor.black, 1.0)
		button3.addTarget(self, action: #selector(ConfigView.didTapOnRightButton3), for: .touchUpInside)
		addSubview(button3)
		self.initLayout()
	}
	
	func initLayout(){
		self.button3Con = LayoutUtils.layoutExact(v: button3, parent: self, x: 2*Constants.SIZE.CONFIG_MARKER_SIZE + 2*Constants.SIZE.CONFIG_MARKER_PADDING, y: 0, width: Constants.SIZE.CONFIG_MARKER_SIZE, height: Constants.SIZE.CONFIG_MARKER_SIZE)
		setupC(
			children: [
				button3
			],
			constraints: [
				button3Con
			],
			parent: self
		)
	}
	
	@objc func didTapOnRightButton3(_ sender:UITapGestureRecognizer){
		self.delegate?.didReceiveConfig(input: "3")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


