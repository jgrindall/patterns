
import UIKit
import ReSwift

class FileCell: UICollectionViewCell {
	private var textView: UILabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 20))
	private var tickImageView = UIImageView(frame: CGRect(x: 80, y: 10, width: 20, height: 20))
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: Constants.SIZE.FILE_CELL_WIDTH, height: Constants.SIZE.FILE_CELL_HEIGHT))
		self.layer.masksToBounds = false
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOpacity = 0.5
		self.layer.shadowOffset = CGSize(width: -1, height: 1)
		self.layer.shadowRadius = 1
		
		self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
		self.layer.shouldRasterize = true
		
		self.layer.rasterizationScale = UIScreen.main.scale
	}
	
	override var isSelected: Bool{
		didSet{
			if self.isSelected{
				self.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
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
