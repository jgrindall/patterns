
import UIKit
import RSClipperWrapper

class Geom{
	
	var SIZE:CGFloat = 500.0
	var origin = CGPoint(x: 0.0, y: 0.0)
	var transforms:[CGAffineTransform]
	var lineGraph:LineGraph
	var transLineGraphs:[LineGraph]
	var frame:CGRect
	var text:String = ""
	var polygons:[Polygon] = []
	
	init(){
		transforms = []
		lineGraph = LineGraph()
		transLineGraphs = []
		frame = CGRect(x: 0, y: 0, width: 1024, height: 768)
		setTransGroup(name:"p3m1")
		setText(_text: "")
	}
	
	public func getPolygons() -> [Polygon]{
		return self.polygons
	}
	
	private func makePolygons(){
		var transPolys:[Polygon] = []
		for lineGraph:LineGraph in transLineGraphs{
			transPolys = transPolys + lineGraph.toPolygonArray(thickness: 30)
		}
		let uTransPolys = MathUtils.union(ps: transPolys)
		let uTransPolys2 = MathUtils.union(ps: uTransPolys)
		polygons = uTransPolys2
	}
	
	private func makeTransformedLines(){
		transLineGraphs = []
		for trans:CGAffineTransform in transforms{
			transLineGraphs.append(lineGraph.t(t: trans))
		}
	}
	
	private func makeLines(){
		var lines:[LineSegment] = []
		var textArr = text.split(separator: " ")
		var state = ""
		let ORIGIN = CGPoint(x: 500, y: 380)
		var p:CGPoint = CGPoint(x: ORIGIN.x, y: ORIGIN.y)
		var dir:CGFloat = 0
		var newX:CGFloat
		var newY:CGFloat
		var dist:Int
		var distF:CGFloat
		var s:String
		for i in 0..<textArr.count{
			// process
			s = String(textArr[i])
			if(state == "fd"){
				dist = Int(s)!
				distF = CGFloat(dist)
				newX = p.x + cos(dir*3.14159/180.0) * distF
				newY = p.y + sin(dir*3.14159/180.0) * distF
				lines.append(LineSegment(
					p0: p,
					p1: CGPoint(x: newX, y: newY)
				))
				p = CGPoint(x: newX, y: newY)
			}
			else if(state == "rt"){
				dist = Int(s)!
				distF = CGFloat(dist)
				dir += distF
			}
			else if(state == "lt"){
				dist = Int(s)!
				distF = CGFloat(dist)
				dir -= distF
			}
			if(s == "fd"){
				state = "fd"
			}
			else if(s == "rt"){
				state = "rt"
			}
			else if(s == "lt"){
				state = "lt"
			}
			else{
				state = ""
			}
		}
		lineGraph = LineGraph(list: LineList(lines: lines))
	}
	
	private func update(){
		//print("Geom update polygons")
		makeLines()
		makeTransformedLines()
		makePolygons()
	}
	
	public func setTransGroup(name:String){
		transforms = MathUtils.getTrans(name: name, origin: origin, size: SIZE, frame: self.frame)
		update()
	}
	
	public func setText(_text:String){
		text = _text
		update()
	}
	
	
}
