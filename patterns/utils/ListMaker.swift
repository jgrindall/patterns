import ReSwift

class ListMaker{
	static func getStuff() -> [ListItemModel] {
		var items = [] as [ListItemModel]
		for _ in 0...3 {
			items.append(ListItemModel(type: "fd", content:"123", clr:UIColor.red, label: "fd", imageSrc: "bulb.png"))
		}
		for _ in 0...3 {
			items.append(ListItemModel(type: "rt", content:"456", clr:UIColor.green, label: "rt", imageSrc: "bulb.png"))
		}
		return items
	}
}
