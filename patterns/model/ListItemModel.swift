import ReSwift

class ListItemModel {
	public var type: String
	public var label:String
	public var content:String
	public var clr:UIColor
	public var imageSrc: String
	init(type:String, content:String, clr:UIColor, label: String, imageSrc: String) {
		self.type = type
		self.content = content
		self.clr = clr
		self.label = label
		self.imageSrc = imageSrc
	}
}
