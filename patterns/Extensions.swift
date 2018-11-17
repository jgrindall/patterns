import Foundation
import CoreGraphics
import UIKit

typealias Polygon = [CGPoint]

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
	return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public extension Int {

	public static var random: Int {
		return Int.random(n: Int.max)
	}

	public static func random(n: Int) -> Int {
		return Int(arc4random_uniform(UInt32(n)))
	}
	

	public static func random(min: Int, max: Int) -> Int {
		return Int.random(n: max - min + 1) + min
	}
}

public extension Double {

	public static var random: Double {
		return Double(arc4random()) / 0xFFFFFFFF
	}
	
	public static func random(min: Double, max: Double) -> Double {
		return Double.random * (max - min) + min
	}
}

public extension Float {
	
	public static var random: Float {
		return Float(arc4random()) / 0xFFFFFFFF
	}
	public static func random(min: Float, max: Float) -> Float {
		return Float.random * (max - min) + min
	}
}

public extension CGFloat {
	
	public static var random: CGFloat {
		return CGFloat(Float.random)
	}
	public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
		return CGFloat.random * (max - min) + min
	}
}

public extension CGPoint {
	
	public static func random(min: CGFloat, max: CGFloat) -> CGPoint {
		return CGPoint(
			x: CGFloat.random(min: min, max: max),
			y: CGFloat.random(min: min, max: max)
		)
	}
}

public extension CGAffineTransform{
	
	public static func getReflectInLine(variable:String, amt:CGFloat) -> CGAffineTransform {
		if(variable == "x="){
			return CGAffineTransform(a: -1.0, b: 0.0, c: 0.0, d: 1.0, tx: 2*amt, ty: 0.0)
		}
		else {
			return CGAffineTransform(a: 1.0, b: 0.0, c: 0.0, d: -1.0, tx: 0, ty: 2*amt)
		}
	}
	
}

public extension UIButton {
	func setBackgroundColor(color: UIColor, forState: UIControlState) {
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
		UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let colorImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		self.setBackgroundImage(colorImage, for: forState)
	}
}

public extension UICollectionViewController{
	func getPaths(_ num:Int) -> [IndexPath]{
		var p:[IndexPath] = []
		for i in 0..<num{
			p.append(IndexPath(row:i, section: 0))
		}
		return p
	}
}


