import UIKit

class LineList{
	var _lines: [LineSegment]
	init(lines:[LineSegment]){
		_lines = lines
	}
	init(){
		_lines = []
	}
	public func getLines()->[LineSegment]{
		return _lines
	}
	func toPolygonArray(thickness:CGFloat) -> Polygon{
		return MathUtils.thicken(points: self.toPoints(), thickness: thickness)
	}
	func toPoints() -> [CGPoint]{
		var p:[CGPoint] = []
		if(_lines.count >= 1){
			p.append(_lines[0].p0())
			for line in _lines{
				p.append(line.p1())
			}
		}
		return p
	}
	func t(t:CGAffineTransform) -> LineList{
		var transLines:[LineSegment] = []
		for line in _lines{
			transLines.append(line.t(t: t))
		}
		return LineList(lines:transLines)
	}
	func drawIn(context:CGContext){
		for line in _lines{
			line.drawIn(context: context)
		}
	}
}
