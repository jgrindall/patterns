
import UIKit
import ReSwift

class FileCell: UICollectionViewCell {
	private var textView: UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
	private var tickImageView = UIImageView(frame: CGRect(x: 80, y: 10, width: 20, height: 20))
	private var markerView = UIView(frame: CGRect(x: 5, y: 40, width: 140, height: 3))
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: Constants.SIZE.FILE_CELL_WIDTH, height: Constants.SIZE.FILE_CELL_HEIGHT))
	}
	
	override var isSelected: Bool{
		didSet{
			if self.isSelected{
				self.backgroundColor = UIColor.clear
				self.tickImageView.isHidden = false
				self.markerView.isHidden = false
			}
			else{
				self.backgroundColor = UIColor.clear
				self.transform = CGAffineTransform.identity
				self.tickImageView.isHidden = true
				self.markerView.isHidden = true
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
		self.contentView.addSubview(textView)
		self.contentView.addSubview(tickImageView)
		self.contentView.addSubview(markerView)
		markerView.backgroundColor = UIColor.black
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
