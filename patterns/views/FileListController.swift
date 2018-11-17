
import UIKit
import ReSwift

private let REUSE_IDENTIFIER = "FileCell"

class FileListController: UICollectionViewController  {
	
	private var items:[FileModel] = []

	override init(collectionViewLayout: UICollectionViewLayout){
		super.init(collectionViewLayout:collectionViewLayout)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
		let file:FileModel = items[indexPath.item]
		store.dispatch(SetSelectedAction(payload: file))
		self.collectionView?.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.centeredVertically)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.collectionView?.delegate = self
		self.view.frame = CGRect(x: 0, y: 0, width: 120, height: 900)
		self.collectionView?.backgroundColor = UIColor.cyan
		self.view.backgroundColor = UIColor.red
	}
	
	func getAllPaths() -> [IndexPath]{
		return getPaths(self.items.count)
	}
	
	func update(items:[FileModel], selected:FileModel?){
		self.items = items
		self.collectionView?.reloadData()
		self.collectionView?.reloadItems(at: getAllPaths())
		if(selected != nil){
			self.collectionView?.selectItem(at: IndexPath(row:0, section: 0), animated: false, scrollPosition: .centeredVertically)
		}
	}
	
	@objc(collectionView:layout:insetForSectionAtIndex:)
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsetsMake(5, 5, 5, 5)
	}
	
	@objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:)
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 5
	}
	
	@objc(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 5
	}

	override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
		return items.count
	}
	
	override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
		collectionView.register(FileCell.self, forCellWithReuseIdentifier: REUSE_IDENTIFIER)
		let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath as IndexPath)
		let index:Int = IndexUtils.indexOf(indexPath: indexPath)
		if let cell = cell as? FileCell{
			cell.loadData(p:items[index])
		}
		return cell
	}
	
	
}

