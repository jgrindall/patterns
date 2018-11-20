import Foundation
import UIKit

class LayoutUtils {
	
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
	
	public static func bottomRight(v:UIView, parent:UIView, margin:CGFloat, width:CGFloat, height:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -margin),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margin),
			v.heightAnchor.constraint(equalToConstant: height)
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
	
	public static func layoutToBottom(v:UIView, parent:UIView, multiplier:CGFloat)->[NSLayoutConstraint] {
		return [
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: multiplier)
		]
	}
	
	public static func layoutFull(v:UIView, parent:UIView)->[NSLayoutConstraint]  {
		return LayoutUtils.layoutToTop(v: v, parent: parent, multiplier: 1)
	}
	
	public static func layoutAboveWithHeight(v:UIView, viewToBeAbove:UIView, height:CGFloat)->[NSLayoutConstraint]  {
		return [
			v.leadingAnchor.constraint(equalTo: viewToBeAbove.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: viewToBeAbove.trailingAnchor),
			v.bottomAnchor.constraint(equalTo: viewToBeAbove.topAnchor),
			v.heightAnchor.constraint(equalToConstant: height)
		]
	}
	
	
}



