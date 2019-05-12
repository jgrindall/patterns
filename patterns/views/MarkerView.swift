
import UIKit

class MarkerView : UIView{
	
	private var bg:UIColor = .clear
	private var fg:UIColor = .clear
	private var width:CGFloat = 5
	
	override init(frame:CGRect){
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func update(bg:UIColor, fg:UIColor, width:CGFloat){
		self.bg = bg
		self.fg = fg
		self.width = width
		self.setNeedsDisplay()
	}
	
	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		let context:CGContext? = UIGraphicsGetCurrentContext()
		context?.clear(self.frame)
		self.bg.setFill()
		UIRectFill(self.frame)
		self.fg.setFill()
		UIRectFill(self.frame.insetBy(dx: 4, dy: 4))
		
		context?.rotate(by: CGFloat.pi*45.0/180.0)
		
		let rectangle:CGRect = CGRect(x: 0, y: 0, width: 300, height: 120)
		context?.setFillColor(UIColor.purple.cgColor)
		context?.setStrokeColor(UIColor.green.cgColor)
		context?.setLineWidth(20)
		context!.fill(rectangle)
		context!.stroke(rectangle)
		
		context!.rotate(by: -CGFloat.pi*45.0/180.0)
		
		
	}
	
}
