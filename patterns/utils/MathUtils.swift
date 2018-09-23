import Foundation
import CoreGraphics
import RSClipperWrapper

class MathUtils {
	
	public static func getViewContainingPoint(p:CGPoint, views:[UIView]) -> UIView?{
		for i in 0..<views.count{
			if(views[i].frame.contains(p)){
				return views[i]
			}
		}
		return nil
	}
	
	public static func getDeletedAt<T>(a:[T], index:Int) -> [T]{
		//eg.  a,b,c,d,e,f,g,h,i   getDeletedAt  3  ->   a,b,c,e,f,g,h,i
		if(a.count == 0){
			return []
		}
		if(index < 0){
			return a
		}
		if(index > a.count - 1){
			return a
		}
		let left = a.prefix(index)
		let right = a.suffix(a.count - index - 1)
		return Array(left + right)
	}
	
	public static func getReplacedAt<T>(a:[T], index:Int, element:T) -> [T]{
		if(a.count == 0){
			return []
		}
		if(index < 0){
			return a
		}
		if(index > a.count - 1){
			return a
		}
		let left = a.prefix(index)
		let right = a.suffix(a.count - index - 1)
		return Array(left + [element] + right)
	}
	
	public static func getInsertedAt<T>(a:[T], index:Int, element:T) -> [T]{
		//eg.  a,b,c,d,e,f,g,h,i   getInsertedAt  3, "X"   ->   a,b,c,X,d,e,f,g,h,i
		if(a.count == 0){
			return []
		}
		if(index <= 0){
			return [element] + a
		}
		if(index >= a.count + 1){
			return a + [element]
		}
		//else index >= 1 and index <= a.count
		let left = a.prefix(index)
		let right = a.suffix(a.count - index)
		return left + [element] + right
	}
	
	public static func getRectContainingPoint(p:CGPoint, rects:[CGRect]) -> CGRect?{
		for i in 0..<rects.count{
			if(rects[i].contains(p)){
				return rects[i]
			}
		}
		return nil
	}
	
	public static func getTransSteps(origin:CGPoint, frame:CGRect, w:CGFloat, h:CGFloat) -> MinMax {
		var xmin:Int = 0
		var xmax:Int = 0
		var ymin:Int = 0
		var ymax:Int = 0
		while(origin.x + CGFloat(xmin) * w > 0){
			xmin = xmin - 1
		}
		while(origin.x + CGFloat(xmax) * w < frame.width - w){
			xmax = xmax + 1
		}
		while(origin.y + CGFloat(ymin) * h > 0){
			ymin = ymin - 1
		}
		while(origin.y + CGFloat(ymax) * h < frame.height - h){
			ymax = ymax + 1
		}
		return MinMax(xmin:xmin, xmax:xmax, ymin:ymin, ymax:ymax)
	}
	
	public static func getIntersection(p0:CGPoint, p1:CGPoint, q0:CGPoint, q1:CGPoint) -> CGPoint?{
		//https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
		let TOL:CGFloat = 0.000001
		// line 1
		let x1:CGFloat = p0.x
		let y1:CGFloat = p0.y
		let x2:CGFloat = p1.x
		let y2:CGFloat = p1.y
		// line 2
		let x3:CGFloat = q0.x
		let y3:CGFloat = q0.y
		let x4:CGFloat = q1.x
		let y4:CGFloat = q1.y
		
		let tNum:CGFloat = 			(x1 - x3)*(y3 - y4) - (y1 - y3)*(x3 - x4)
		let tDenom:CGFloat = 		(x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4)

		let uDenom:CGFloat = 		(x1 - x2)*(y3 - y4) - (y1 - y2)*(x3 - x4)
		
		if(fabs(tDenom) < TOL && fabs(uDenom) < TOL){
			return nil
		}
		let t:CGFloat = tNum/tDenom
		return CGPoint(x: x1 + t*(x2 - x1), y: y1 + t*(y2 - y1))
	}
	
	
	public static func getOffsets(a:CGPoint, b:CGPoint, thickness:CGFloat) -> CGPoint {
		let dx:CGFloat = b.x - a.x
		let dy:CGFloat = b.y - a.y
		let len:CGFloat = sqrt(dx * dx + dy * dy)
		let scale:CGFloat = thickness / (2 * len)
		return CGPoint(x: -scale * dy, y:  scale * dx)
	}
	
	public static func union(ps:[Polygon]) -> [Polygon]{
		return Clipper.unionPolygons(ps, subjFillType: .positive, withPolygons: [], clipFillType: .positive)
	}
	
	public static func thicken(points:Polygon, thickness:CGFloat) -> Polygon{
		var off:CGPoint
		var poly:[CGPoint] = []
		var isFirst:Bool
		var isLast:Bool
		var prevA:[CGPoint] = []
		var prevB:[CGPoint] = []
		var interA:CGPoint?
		var interB:CGPoint?
		var p0a:CGPoint, p1a:CGPoint, p0b:CGPoint, p1b:CGPoint
		if(points.count <= 1){
			return []
		}
		for i in 0 ... points.count - 2{
			isFirst = (i == 0)
			isLast = (i == points.count - 2)
			off = MathUtils.getOffsets(a:points[i], b:points[i + 1], thickness:thickness)
			p0a = CGPoint(x: points[i  ].x + off.x, y: points[i  ].y + off.y)
			p1a = CGPoint(x: points[i+1].x + off.x, y: points[i+1].y + off.y)
			p0b = CGPoint(x: points[i  ].x - off.x, y: points[i  ].y - off.y)
			p1b = CGPoint(x: points[i+1].x - off.x, y: points[i+1].y - off.y)
			if (!isFirst) {
				interA = MathUtils.getIntersection(p0:prevA[0], p1:prevA[1], q0:p0a, q1:p1a)
				interB = MathUtils.getIntersection(p0:prevB[0], p1:prevB[1], q0:p0b, q1:p1b)
				if let _interA = interA {
					poly.insert(_interA, at: 0)
				}
				if let _interB = interB {
					poly.append(_interB)
				}
			}
			if (isFirst) {
				poly.insert(p0a, at: 0)
				poly.append(p0b)
			}
			if (isLast) {
				poly.insert(p1a, at: 0)
				poly.append(p1b)
			}
			if (!isLast) {
				prevA = [p0a, p1a];
				prevB = [p0b, p1b];
			}
		}
		return poly
	}
	
	public static func getTrans(name:String, origin:CGPoint, size:CGFloat, frame:CGRect) -> [CGAffineTransform]{
		if(name == "p3m1"){
			return GroupP3M1.getTrans(origin:origin, size:size, frame:frame)
		}
		return GroupP3M1.getTrans(origin:origin, size:size, frame:frame)
	}

}


