
import UIKit
import ReSwift

class DragItemModel {
	public var type: String
	public var label:String
	public var imageSrc: String
	init(type:String, label: String, imageSrc: String) {
		self.type = type
		self.label = label
		self.imageSrc = imageSrc
	}
}
