
import UIKit
import ReSwift

typealias DragItems = [DragItemModel]
typealias DragItemsHash = [String: DragItems]

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

extension DragItemModel: Equatable {}

func ==(lhs: DragItemModel, rhs: DragItemModel) -> Bool {
	return (lhs.type == rhs.type && lhs.label == rhs.label && lhs.imageSrc == rhs.imageSrc)
}
