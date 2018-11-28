import ReSwift

typealias DragItems = [DragItemModel]
typealias DragItemsState = [String: DragItems]

class DragItemModel {
	public var type: String
	public var clr:String
	public var content:String
	public var imageSrc: String
	init(type:String, content:String, label: String, imageSrc: String) {
		self.type = type
		self.clr = label
		self.content = content
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
	return (lhs.type == rhs.type && lhs.clr == rhs.clr && lhs.imageSrc == rhs.imageSrc)
}


