
import UIKit
import RSClipperWrapper

class DrawingView : UIView{
	
	var polygons:[Polygon] = []
	
	override init(frame:CGRect){
		super.init(frame: frame)
		self.backgroundColor = UIColor.white
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public func setPolygons(ps:[Polygon]){
		polygons = ps
	}
	
	public func update(){
		self.setNeedsDisplay()
	}
	
	private func drawPolygon(context:CGContext, p:Polygon){
		context.setLineWidth(1.0)
		context.setStrokeColor(UIColor.gray.cgColor)
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
		print("view update")
		let context:CGContext? = UIGraphicsGetCurrentContext()
		context?.clear(self.frame)
		UIColor.white.setFill()
		UIRectFill(self.frame)
		for i in 0..<polygons.count{
			drawPolygon(context: context!, p: polygons[i])
		}
	}
	
}