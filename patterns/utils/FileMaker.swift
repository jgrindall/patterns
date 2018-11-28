import ReSwift

class FileMaker{
	static func getStuff(_ n: Int) -> DragItems {
		var items = [] as [DragItemModel]
		for _ in 0...n {
			items.append(DragItemModel(type: "fd", content:"ccc", label: "fd", imageSrc: "up.png"))
		}
		return items
	}
	
	static func mapFileDataToItems(_ flows: [Flow]) -> DragItemsState {
		var dict:[String:DragItems] = [:]
		for i in 0..<flows.count{
			let f:Flow = flows[i]
			dict[f.name] = FileMaker.getStuff(f.data.count)
		}
		return dict
	}
}


