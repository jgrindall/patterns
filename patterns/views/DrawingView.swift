
import UIKit

class DrawingView : UIView{
	
	private var polygons:[Polygon] = []
	
	override init(frame:CGRect){
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func setPolygons(_ ps:[Polygon]) -> DrawingView{
		polygons = ps
		return self
	}
	
	private func drawPolygon(context:CGContext, p:Polygon){
		context.setLineWidth(4.0)
		context.setStrokeColor(UIColor.cyan.cgColor)
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
	
	public func update(){
		//self.drawingConfigState = state
		self.setNeedsDisplay()
	}

	public override func draw(_ rect: CGRect) {
		super.draw(rect)
		let context:CGContext? = UIGraphicsGetCurrentContext()
		context?.clear(self.frame)
		Constants.COLORS.DARK_COLOR.setFill()
		UIRectFill(self.frame)
		print(polygons)
		for i in 0..<polygons.count{
			drawPolygon(context: context!, p: polygons[i])
		}
	}
	
}
