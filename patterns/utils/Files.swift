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
		var files:[FileModel] = []
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
			print("Error", error)
		}
		return []
	}
	
	public static func loadOne(name:String) -> FileModel?{
		do {
			let file = try Disk.retrieve(_getFile(name), from: .documents, as: FileModel.self)
			return file
		}
		catch{
			print("Error")
			return nil
		}
	}
	
	public static func save(name:String, fileModel:FileModel) -> Bool{
		let file:FileModel = FileModel(userId: 123, id: 123, title: "title", body: "body body body body")
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

}
