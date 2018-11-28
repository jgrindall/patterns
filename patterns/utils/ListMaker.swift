import ReSwift

class ListMaker{
	static func getStuff() -> [ListItemModel] {
		var items = [] as [ListItemModel]
		items.append(ListItemModel(type: "fd", content:"50", clr:UIColor.red, label: "fd", imageSrc: "up.png"))
		items.append(ListItemModel(type: "fd", content:"100", clr:UIColor.red, label: "fd", imageSrc: "up.png"))
		items.append(ListItemModel(type: "fd", content:"200", clr:UIColor.red, label: "fd", imageSrc: "up.png"))
		
		items.append(ListItemModel(type: "lt", content:"90", clr:UIColor.green, label: "rt", imageSrc: "lt.png"))
		items.append(ListItemModel(type: "rt", content:"90", clr:UIColor.green, label: "rt", imageSrc: "rt.png"))
		
		return items
	}
	
	static func getClrForItem(item:ListItemModel) -> UIColor{
		return UIColor.red
	}
}
