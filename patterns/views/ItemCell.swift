
import UIKit
import ReSwift

class ItemCell: UICollectionViewCell {
	private var imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
	private var textView: UITextView = UITextView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
	}
	
	public func loadData(p:DragItemModel){
		self.imageView.image = UIImage(named: p.imageSrc)
		self.textView.text = p.label
		textView.font = UIFont(name: "Verdana", size: 14)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(imageView)
		self.addSubview(textView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
