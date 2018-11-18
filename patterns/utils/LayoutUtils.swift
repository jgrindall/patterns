import Foundation
import UIKit

class LayoutUtils {
	
	public static func bottomLeft(v:UIView, parent:UIView, margin:CGFloat, width:CGFloat, height:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margin),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margin),
			v.heightAnchor.constraint(equalToConstant: height)
		])
	}
	
	public static func bottomRight(v:UIView, parent:UIView, margin:CGFloat, width:CGFloat, height:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -margin),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margin),
			v.heightAnchor.constraint(equalToConstant: height)
		])
	}
	
	public static func layoutToLeftWithWidth(v:UIView, parent:UIView, width:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.widthAnchor.constraint(equalToConstant: width),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		])
	}
	
	public static func layoutToRightWithMargin(v:UIView, parent:UIView, margin:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: margin),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		])
	}
	
	public static func layoutToLeftWithMultiplier(v:UIView, parent:UIView, multiplier:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: multiplier),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		])
	}
	
	public static func layoutToRightWithMultiplier(v:UIView, parent:UIView, multiplier:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: multiplier),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		])
	}
	
	public static func layoutToTop(v:UIView, parent:UIView, multiplier:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.topAnchor.constraint(equalTo: parent.topAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.5, constant: 0)
		])
	}
	
	public static func layoutToBottom(v:UIView, parent:UIView, multiplier:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: 0.5, constant: 0)
		])
	}
	
	public static func layoutFull(v:UIView, parent:UIView) {
		LayoutUtils.layoutToTop(v: v, parent: parent, multiplier: 1)
	}
	
	public static func layoutAboveWithHeight(v:UIView, viewToBeAbove:UIView, height:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: viewToBeAbove.leadingAnchor),
			v.trailingAnchor.constraint(equalTo: viewToBeAbove.trailingAnchor),
			v.bottomAnchor.constraint(equalTo: viewToBeAbove.topAnchor),
			v.heightAnchor.constraint(equalToConstant: height)
		])
	}
	
	
}



