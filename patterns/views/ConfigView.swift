
import UIKit
import ReSwift

protocol ConfigDelegate {
	func didReceiveConfig(input: String)
}

class ConfigView: UIView {
	
	private var button3:UIButton?
	var delegate: ConfigDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let button1 = UIButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 20))
		button1.setImage(UIImage(named: "notification"), for: .normal)
		button1.setTitle("one", for: .normal)
		
		button1.addTarget(self, action: #selector(ConfigView.didTapOnRightButton), for: .touchUpInside)
		let button2 = UIButton(frame: CGRect.init(x: 40, y: 8, width: 60, height: 20))
		button2.setImage(UIImage(named: "notification"), for: .normal)
		button2.setTitle("tow", for: .normal)
		button3 = UIButton(frame: CGRect.init(x: 80, y: 8, width: 60, height: 20))
		button3?.setImage(UIImage(named: "notification"), for: .normal)
		button3?.setTitle("three", for: .normal)
		
		button3?.addTarget(self, action: #selector(ConfigView.didTapOnRightButton), for: .touchUpInside)
		
		addSubview(button1)
		addSubview(button2)
		addSubview(button3!)
	}
	
	@objc func didTapOnRightButton(_ sender:UITapGestureRecognizer){
		self.delegate?.didReceiveConfig(input: "3")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


