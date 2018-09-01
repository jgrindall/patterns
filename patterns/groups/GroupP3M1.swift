import Foundation
import CoreGraphics

class GroupP3M1 {
	
	private static func getBaseTrans(origin:CGPoint, size:CGFloat) -> [CGAffineTransform]{
		let a = CGAffineTransform.getReflectInLine(variable: "x=", amt: origin.x + size)
		let b = CGAffineTransform.getReflectInLine(variable: "y=", amt: origin.x + size)
		return [
			CGAffineTransform.identity,
			a,
			b,
			a.concatenating(b)
		]
	}
	
	
	public static func getTrans(origin:CGPoint, size:CGFloat, frame:CGRect) -> [CGAffineTransform]{
		var transforms:[CGAffineTransform] = []
		let baseTransforms:[CGAffineTransform] = GroupP3M1.getBaseTrans(origin: origin, size: size)
		let steps:MinMax = MathUtils.getTransSteps(origin: origin, frame: frame, w: 2*size, h: 2*size)
		for i:Int in steps.xmin()...steps.xmax(){
			for j:Int in steps.ymin()...steps.ymax(){
				for trans in baseTransforms{
					transforms.append(trans.concatenating(CGAffineTransform.init(translationX: 2*size*CGFloat(i), y: 2*size*CGFloat(j))))
				}
			}
		}
		return transforms
	}

}


