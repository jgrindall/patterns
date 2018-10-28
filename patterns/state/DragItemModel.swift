import ReSwift

typealias DragItems = [DragItemModel]
typealias DragItemsState = [String: DragItems]

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

extension Array where Element == DragItemModel {
	static func ==(lhs: Array<Element>, rhs: Array<Element>) -> Bool {
		//TODO - fix?
		return (lhs.count == rhs.count)
	}
}

func ==(lhs: DragItemsState, rhs: DragItemsState) -> Bool {
	return (lhs.count == rhs.count)
}

extension DragItemModel: Equatable {}

func ==(lhs: DragItemModel, rhs: DragItemModel) -> Bool {
	return (lhs.type == rhs.type && lhs.label == rhs.label && lhs.imageSrc == rhs.imageSrc)
}


