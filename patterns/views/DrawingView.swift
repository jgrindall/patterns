
import UIKit
import RSClipperWrapper

class DrawingView : UIView{
	
	private var polygons:[Polygon] = []
	
	override init(frame:CGRect){
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func setPolygons(ps:[Polygon]) -> DrawingView{
		polygons = ps
		return self
	}
	
	public func update(){
		self.setNeedsDisplay()
	}
	
	private func drawPolygon(context:CGContext, p:Polygon){
		context.setLineWidth(6.0)
		context.setStrokeColor(UIColor.white.cgColor)
		context.setLineCap(.square)
		for i in 0..<p.count{
			if(i == 0){
				context.move(to: p[i])
			}
			else{
				context.addLine(to: p[i])
			}
		}
		context.addLine(to: p[0])
		context.strokePath()
	}

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		let context:CGContext? = UIGraphicsGetCurrentContext()
		context?.clear(self.frame)
		Constants.COLORS.DARK_COLOR.setFill()
		UIRectFill(self.frame)
		for i in 0..<polygons.count{
			drawPolygon(context: context!, p: polygons[i])
		}
	}
	
}
