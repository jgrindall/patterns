
import UIKit

class SymmPathView : UIView{
	
	override init(frame:CGRect){
		super.init(frame: frame)
		self.isOpaque = false
		self.backgroundColor = .clear
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func update(){
		self.setNeedsDisplay()
	}

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		let context:CGContext? = UIGraphicsGetCurrentContext()
		context?.clear(self.frame)
		let ctx = UIGraphicsGetCurrentContext()!
		ctx.setStrokeColor(UIColor.red.cgColor)
		let circleRect = CGRect(x: 0, y: 0, width: 420, height: 250)
		ctx.strokeEllipse(in: circleRect)
	}
	
}
