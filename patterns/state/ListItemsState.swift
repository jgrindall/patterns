import ReSwift

class ListItemModel {
	public var type: String
	public var label:String
	public var clr:UIColor
	public var imageSrc: String
	init(type:String, clr:UIColor, label: String, imageSrc: String) {
		self.type = type
		self.clr = clr
		self.label = label
		self.imageSrc = imageSrc
	}
}
