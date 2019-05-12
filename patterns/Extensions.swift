import Foundation
import CoreGraphics
import UIKit

typealias Polygon = [CGPoint]
typealias Polygons = [Polygon]

func ==(lhs: Polygon, rhs: Polygon) -> Bool {
	if (lhs.count != rhs.count){
		return false
	}
	for i in 0..<(lhs.count){
		let eq = (lhs[i] == rhs[i])
		if(!eq){
			return false
		}
	}
	return true
}

func ==(lhs: Polygons, rhs: Polygons) -> Bool {
	if (lhs.count != rhs.count){
		return false
	}
	for i in 0..<lhs.count{
		let eq = (lhs[i] == rhs[i])
		if(!eq){
			return false
		}
	}
	return true
}

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

public extension UIView{
	func setUpRoundButton(_ icon:UIImageView?, _ rad:CGFloat = 30.0, _ bgClr:UIColor = .white, _ borderClr:UIColor = UIColor.gray, _ borderWidth:CGFloat = 3.0){
		self.layer.masksToBounds = true
		self.backgroundColor = bgClr
		self.layer.cornerRadius = rad
		self.layer.borderWidth = borderWidth
		self.layer.borderColor = borderClr.cgColor
		if(icon != nil){
			self.addSubview(icon!)
			icon?.isUserInteractionEnabled = false
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

public extension UIViewController{
	func getNavHeight() ->CGFloat{
		return self.navigationController!.navigationBar.frame.size.height
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

public extension UILabel {
	var substituteFontName : String {
		get { return self.font.fontName }
		set {
			if(self.font == nil){
				self.font = UIFont(name: newValue, size: 17)
			}
			else if self.font.fontName.range(of:"-Bd") == nil {
				self.font = UIFont(name: newValue, size: self.font.pointSize)
			}
		}
	}
	var substituteFontNameBold : String {
		get { return self.font.fontName }
		set {
			if(self.font == nil){
				self.font = UIFont(name: newValue, size: 17)
			}
			else if self.font.fontName.range(of:"-Bd") != nil {
				self.font = UIFont(name: newValue, size: self.font.pointSize)
			}
		}
	}
}

public extension UITextField {
	var substituteFontName : String {
		get { return self.font!.fontName }
		set {
			if(self.font == nil){
				self.font = UIFont(name: newValue, size: 17)
			}
			else{
				self.font = UIFont(name: newValue, size: (self.font?.pointSize)!)
			}
		}
	}
}

public extension CALayer {
	
	func colorOfPoint(point:CGPoint) -> CGColor {
		var pixel: [CUnsignedChar] = [0, 0, 0, 0]
		let colorSpace = CGColorSpaceCreateDeviceRGB()
		let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
		let context = CGContext(data: &pixel, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
		context!.translateBy(x: -point.x, y: -point.y)
		self.render(in: context!)
		let red: CGFloat   = CGFloat(pixel[0]) / 255.0
		let green: CGFloat = CGFloat(pixel[1]) / 255.0
		let blue: CGFloat  = CGFloat(pixel[2]) / 255.0
		let alpha: CGFloat = CGFloat(pixel[3]) / 255.0
		let color = UIColor(red:red, green: green, blue:blue, alpha:alpha)
		return color.cgColor
	}
}

public extension UIImage {
	class func pixelWithColor(color: UIColor) -> UIImage {
		let rect = CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 1, height: 1))
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()!
		context.setFillColor(color.cgColor)
		context.fill(rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image!
	}
}


