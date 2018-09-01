import UIKit

struct MinMax {
	let _xmin: Int
	let _xmax: Int
	let _ymin: Int
	let _ymax: Int
	init(xmin: Int, xmax:Int, ymin:Int, ymax:Int) {
		_xmin = xmin
		_xmax = xmax
		_ymin = ymin
		_ymax = ymax
	}
	func xmin()->Int{
		return _xmin
	}
	func xmax()->Int{
		return _xmax
	}
	func ymin()->Int{
		return _ymin
	}
	func ymax()->Int{
		return _ymax
	}
}
