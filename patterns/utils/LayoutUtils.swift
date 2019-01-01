import Foundation
import UIKit

class LayoutUtils {
	
	public static func layoutExact(v:UIView, parent:UIView, x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat)->[NSLayoutConstraint] {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: x),
			v.topAnchor.constraint(equalTo: parent.topAnchor, constant: y),
			v.widthAnchor.constraint(equalToConstant: width),
			v.heightAnchor.constraint(equalToConstant: height)
		];
	}
	
	public static func centreRight(v:UIView, parent:UIView, margin:CGFloat, width:CGFloat, height:CGFloat)->[NSLayoutConstraint] {
		return [
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -margin),
			v.widthAnchor.constraint(equalToConstant: width),
			v.centerYAnchor.constraint(equalTo: parent.centerYAnchor),
			v.heightAnchor.constraint(equalToConstant: height)
		];
	}
	
	public static func absolute(v:UIView, parent:UIView, rect:CGRect)->[NSLayoutConstraint] {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant:rect.minX),
			v.topAnchor.constraint(equalTo: parent.topAnchor, constant:rect.minY),
			v.widthAnchor.constraint(equalToConstant: rect.width),
			v.heightAnchor.constraint(equalToConstant: rect.height)
		]
	}
	
	public static func bottomLeft(v:UIView, parent:UIView, margin:CGFloat, width:CGFloat, height:CGFloat)->[NSLayoutConstraint] {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margin),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margin),
			v.heightAnchor.constraint(equalToConstant: height)
		];
	}
	
	public static func bottomLeftWithMargins(v:UIView, parent:UIView, marginBottom:CGFloat, width:CGFloat, height:CGFloat, marginLeft:CGFloat)->[NSLayoutConstraint] {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: marginLeft),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -marginBottom),
			v.heightAnchor.constraint(equalToConstant: height)
		];
	}
	
	public static func bottomRight(v:UIView, parent:UIView, margin:CGFloat, width:CGFloat, height:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -margin),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margin),
			v.heightAnchor.constraint(equalToConstant: height)
		]
	}
	
	public static func layoutToLeftWithWidthAndTopMargin(v:UIView, parent:UIView, width:CGFloat, topMargin:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.topAnchor.constraint(equalTo: parent.topAnchor, constant: topMargin)
		]
	}
	
	public static func layoutToLeftWithWidth(v:UIView, parent:UIView, width:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		]
	}
	
	public static func layoutToRightWithMargin(v:UIView, parent:UIView, margin:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margin),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		]
	}
	
	public static func layoutToLeftWithMultiplier(v:UIView, parent:UIView, multiplier:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: multiplier),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		]
	}
	
	public static func layoutToRightWithMultiplier(v:UIView, parent:UIView, multiplier:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: multiplier),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		]
	}
	
	public static func layoutToTopWithMargin(v:UIView, parent:UIView, margin:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.topAnchor.constraint(equalTo: parent.topAnchor, constant: margin),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor, constant: -margin)
		]
	}
	
	public static func layoutToTop(v:UIView, parent:UIView, multiplier:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.topAnchor.constraint(equalTo: parent.topAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: multiplier)
		]
	}
	
	public static func layoutToTopWithHeight(v:UIView, parent:UIView, height:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.topAnchor.constraint(equalTo: parent.topAnchor),
			v.heightAnchor.constraint(equalToConstant: height)
		]
	}
	
	public static func layoutToBottom(v:UIView, parent:UIView, multiplier:CGFloat, constant:CGFloat = 0.0)->[NSLayoutConstraint] {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: constant),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: multiplier)
		]
	}
	
	public static func layoutFull(v:UIView, parent:UIView)->[NSLayoutConstraint]  {
		return LayoutUtils.layoutToTop(v: v, parent: parent, multiplier: 1)
	}
	
}



