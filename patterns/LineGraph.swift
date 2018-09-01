
import UIKit
import RSClipperWrapper

class LineGraph{
	var _list:LineList
	var _children:[LineGraph]
	init(){
		_list = LineList()
		_children = []
	}
	init(list:LineList, children:[LineGraph]){
		_list = list
		_children = children
	}
	init(list:LineList){
		_list = list
		_children = []
	}
	func addChild(lineGraph:LineGraph){
		_children.append(lineGraph)
	}
	func t(t:CGAffineTransform) -> LineGraph{
		var newChildren:[LineGraph] = []
		for c in _children{
			newChildren.append(c.t(t: t))
		}
		return LineGraph(list: _list.t(t: t), children: newChildren)
	}
	func getList()->LineList{
		return _list
	}
	func getChildren()->[LineGraph]{
		return _children
	}
	func toPolygonArray(thickness:CGFloat) -> [ Polygon ]{
		var polys:[ Polygon ] = []
		polys.append(self._list.toPolygonArray(thickness: thickness))
		for c in _children{
			polys = polys + c.toPolygonArray(thickness: thickness)
		}
		return Clipper.unionPolygons([], withPolygons:polys)
	}
	func drawIn(context:CGContext){
		_list.drawIn(context: context)
		for c in _children{
			c.drawIn(context: context)
		}
	}
}
