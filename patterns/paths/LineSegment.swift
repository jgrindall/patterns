
import UIKit

struct LineSegment {
	let _p0: CGPoint
	let _p1: CGPoint
	init(p0: CGPoint, p1:CGPoint) {
		_p0 = p0
		_p1 = p1
	}
	private func atTime(t:CGFloat) -> CGPoint{
		return CGPoint(x: _p0.x + t*(_p1.x - _p0.x), y: _p0.y + t*(_p1.y - _p0.y))
	}
	func p0()->CGPoint{
		return _p0
	}
	func p1()->CGPoint{
		return _p1
	}
	func t(t:CGAffineTransform) -> LineSegment{
		return LineSegment(p0:_p0.applying(t), p1:_p1.applying(t))
	}
	func drawIn(context:CGContext){
		context.setLineWidth(1.0)
		context.setStrokeColor(UIColor.gray.cgColor)
		context.move(to: _p0)
		context.addLine(to: _p1)
	}
}

