import ReSwift

struct Flow: Codable {
	let name: String
	let data:[Int]
}

struct FileModel: Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
	let imageSrc:String
	let data:[Flow]
	var tabNames: [String] {
		return ["a", "b", "c"]
	}
}

func ==(lhs: FileModel, rhs: FileModel) -> Bool {
	return (lhs.id == rhs.id)
}
