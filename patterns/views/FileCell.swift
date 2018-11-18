
import UIKit
import ReSwift

class FileCell: UICollectionViewCell {
	private var textView: UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
	private var tickImageView = UIImageView(frame: CGRect(x: 80, y: 10, width: 20, height: 20))
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
	}
	
	override var isSelected: Bool{
		didSet{
			if self.isSelected{
				self.backgroundColor = UIColor.orange
				self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
				self.tickImageView.isHidden = false
			}
			else{
				self.backgroundColor = UIColor.clear
				self.transform = CGAffineTransform.identity
				self.tickImageView.isHidden = true
			}
		}
	}
	
	public func loadData(p:FileModel){
		self.textView.text = p.title
		textView.font = UIFont(name: "Verdana", size: 14)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		tickImageView.isHidden = true
		tickImageView.image = UIImage(named: "tick.png")
		self.addSubview(textView)
		self.addSubview(tickImageView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
