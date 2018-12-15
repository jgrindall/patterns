import ReSwift

class ListMaker{
	static func getStuff() -> [ListItemModel] {
		var items = [] as [ListItemModel]
		items.append(ListItemModel(type: "fd", content:"50", clr:Constants.COLORS.COLOR2, label: "fd", imageSrc: "up.png"))
		items.append(ListItemModel(type: "fd", content:"100", clr:Constants.COLORS.COLOR2, label: "fd", imageSrc: "up.png"))
		items.append(ListItemModel(type: "fd", content:"200", clr:Constants.COLORS.COLOR2, label: "fd", imageSrc: "up.png"))
		
		items.append(ListItemModel(type: "lt", content:"90", clr:Constants.COLORS.COLOR3, label: "rt", imageSrc: "lt.png"))
		items.append(ListItemModel(type: "rt", content:"90", clr:Constants.COLORS.COLOR3, label: "rt", imageSrc: "rt.png"))
		
		return items
	}
	
}
