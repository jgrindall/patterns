
import UIKit

class BlobView : UIView{
	
	private var clr:UIColor = .green
	private var width:CGFloat = 25
	
	override init(frame:CGRect){
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func update(clr:UIColor, width:CGFloat){
		self.clr = clr
		self.width = width
		self.setNeedsDisplay()
	}
	
	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		let context:CGContext? = UIGraphicsGetCurrentContext()
		context?.clear(self.frame)
		self.clr.setFill()
		let rectangle:CGRect = CGRect(x: 0.0, y: 0.0, width:self.width, height:self.width)
		context!.fillEllipse(in: rectangle)
		context?.setFillColor(UIColor.purple.cgColor)
	}
	
}
