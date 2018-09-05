import Foundation
import CoreGraphics
import RSClipperWrapper

class IndexUtils {

	public static func indexOf(indexPath:NSIndexPath) -> Int{
		return indexPath.item
	}
	
	public static func indexOf(indexPath:IndexPath) -> Int{
		return indexPath.item
	}
	
	public static func indexPathOf(index:Int) -> NSIndexPath{
		return NSIndexPath(item: index, section: 0)
	}


}


