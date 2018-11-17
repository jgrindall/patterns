import Foundation
import UIKit

class LayoutUtils {
	
	public static func layoutToLeft(v:UIView, parent:UIView, multiplier:CGFloat) {
		v.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			v.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
			v.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: multiplier),
			v.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
			v.heightAnchor.constraint(equalTo: parent.heightAnchor)
		])
	}
	
	public static func layoutToRight(v:UIView, parent:UIView, multiplier:CGFloat) {
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



