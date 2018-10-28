import ReSwift

class ListMaker{
	static func getStuff() -> [ListItemModel] {
		var items = [] as [ListItemModel]
		for _ in 0...5 {
			items.append(ListItemModel(type: "fd", clr:UIColor.red, label: "fd", imageSrc: "img.png"))
		}
		return items
	}
}
