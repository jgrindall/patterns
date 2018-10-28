import Foundation
import CoreGraphics
import RSClipperWrapper
import Disk

class Files {
	
	private static func _getFile(_ name:String) -> String{
		return name + ".json"
	}
	
	public static func loadAll() -> [FileModel]{
		let fileManager = FileManager.default
		let dummyModel1 = FileModel(userId: 1, id: 1, title: "title1", body: "title1", imageSrc: "pat1.jpg", data:[
			Flow(name: "page0", data: [1, 2, 3, 4]),
			Flow(name: "page1", data: [8, 6, 5, 1])
		])
		let dummyModel2 = FileModel(userId: 1, id: 2, title: "title2", body: "title2", imageSrc: "pat2.jpg", data:[
			Flow(name: "page0", data: [11, 2, 13, -4]),
			Flow(name: "page1", data: [4, 16, 15, 1])
		])
		var files:[FileModel] = [dummyModel1, dummyModel2]
		let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		do {
			let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
			let names = fileURLs.map{
				$0.deletingPathExtension().lastPathComponent
			}
			for name in names{
				let file:FileModel? = loadOne(name: name)
				if let actualFile = file {
					files.append(actualFile)
				}
			}
			return files
		}
		catch let error as NSError {
			print("fileManager Error", error)
		}
		return []
	}
	
	public static func loadOne(name:String) -> FileModel?{
		do {
			let file = try Disk.retrieve(_getFile(name), from: .documents, as: FileModel.self)
			return file
		}
		catch{
			print("Error", error)
			return nil
		}
	}
	
	public static func save(name:String, fileModel:FileModel) -> Bool{
		let file:FileModel = FileModel(userId: 123, id: 123, title: "title", body: "body body body body", imageSrc:"", data:[])
		do {
			try Disk.save(file, to: .documents, as: _getFile(name))
		}
		catch let error as NSError {
			print("error", error)
			return false
		}
		print("saved")
		return true
	}
	
	public static func getBlank() -> FileModel{
		return FileModel(userId: 123, id: 123, title: "title", body: "body body body body", imageSrc:"", data:[])
	}

}
