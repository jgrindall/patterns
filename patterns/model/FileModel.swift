import ReSwift

struct FileModel: Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
	let imageSrc:String
	let data:Polygons
	let bgColor:[Int]
}

func ==(lhs: FileModel, rhs: FileModel) -> Bool {
	return (lhs.id == rhs.id)
}
