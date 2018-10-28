import ReSwift

class FileMaker{
	static func getStuff(_ n: Int) -> DragItems {
		var items = [] as [DragItemModel]
		for _ in 0...n {
			items.append(DragItemModel(type: "fd", label: "fd", imageSrc: "img.png"))
		}
		return items
	}
	
	static func mapFileToItems(_ flows: [Flow]) -> DragItemsState {
		let data:DragItemsState = ["0":FileMaker.getStuff(6), "1":FileMaker.getStuff(4)]
		return data
	}
}



/*

typealias DragItems = [DragItemModel]
typealias DragItemsState = [String: DragItems]

*/
