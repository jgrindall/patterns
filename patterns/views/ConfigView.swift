
import UIKit
import ReSwift

protocol ConfigDelegate {
	func didReceiveConfig(input: String)
}

class ConfigView: UIView {
	
	private var button1:UIButton?
	private var button2:UIButton?
	private var button3:UIButton?
	var delegate: ConfigDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		button1 = UIButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 20))
		button1?.setImage(UIImage(named: "notification"), for: .normal)
		button1?.setTitle("one", for: .normal)
		
		button2 = UIButton(frame: CGRect.init(x: 40, y: 8, width: 60, height: 20))
		button2?.setImage(UIImage(named: "notification"), for: .normal)
		button2?.setTitle("tow", for: .normal)
		
		button3 = UIButton(frame: CGRect.init(x: 80, y: 8, width: 60, height: 20))
		button3?.setImage(UIImage(named: "notification"), for: .normal)
		button3?.setTitle("three", for: .normal)
		
		button1?.addTarget(self, action: #selector(ConfigView.didTapOnRightButton1), for: .touchUpInside)
		button2?.addTarget(self, action: #selector(ConfigView.didTapOnRightButton2), for: .touchUpInside)
		button3?.addTarget(self, action: #selector(ConfigView.didTapOnRightButton3), for: .touchUpInside)
		
		addSubview(button1!)
		addSubview(button2!)
		addSubview(button3!)
	}
	
	public func load(state:DrawingConfigState){
		button3?.backgroundColor = state.bg
		button3?.setBackgroundColor(color: state.bg, forState: .normal)
		button2?.backgroundColor = state.fg
		button2?.setBackgroundColor(color: state.fg, forState: .normal)
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


