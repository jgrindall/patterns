
import UIKit
import RSClipperWrapper

class Geom{
	
	var SIZE:CGFloat = 500.0
	var origin = CGPoint(x: 0.0, y: 0.0)
	var transforms:[CGAffineTransform]
	var frame:CGRect
	var polygonsIn:Polygons = []
	var polygons:Polygons = []
	
	init(){
		transforms = []
		frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
		_ = setTransGroup(name:"p3m1")
	}
	
	public func getPolygons() -> Polygons{
		return self.polygons
	}
	
	private func applyTrans(_ t:CGAffineTransform, _ polygon:Polygon)->Polygon{
		var pts:Polygon = []
		for pt:CGPoint in polygon{
			pts.append(pt.applying(t))
		}
		return pts
	}
	
	public func update(){
		polygons = []
		for p:Polygon in polygonsIn{
			for trans:CGAffineTransform in transforms{
				polygons.append(applyTrans(trans, p))
			}
		}
	}
	
	public func setTransGroup(name:String) -> Geom{
		transforms = MathUtils.getTrans(name: name, origin: origin, size: SIZE, frame: self.frame)
		return self
	}
	
	public func setPolygons(_ p:Polygons) -> Geom{
		polygonsIn = p
		return self
	}
	
	
}
