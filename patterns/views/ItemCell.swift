
import UIKit
import ReSwift

class ItemCell: UICollectionViewCell {
	
	private var imgView: UIImageView = UIImageView(frame: CGRect())
	private var label: UITextView = UITextView(frame: CGRect())
	private var imgConstraints:[NSLayoutConstraint] = []
	private var labelConstraints:[NSLayoutConstraint] = []
	
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: Constants.SIZE.DRAG_SIZE, height: Constants.SIZE.DRAG_SIZE))
		self.layer.masksToBounds = true
		self.layer.cornerRadius = Constants.SIZE.DRAG_SIZE/2
	}
	
	public func loadData(p:DragItemModel){
		//self.backgroundColor = p.clr
		self.imgView.image = UIImage(named: p.imageSrc)
		self.label.text = p.clr
		label.backgroundColor = UIColor.clear
		label.font = UIFont(name: "Verdana", size: 14)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(imgView)
		self.addSubview(label)
		self.initLayout()
	}
	
	func initLayout(){
		self.imgView.translatesAutoresizingMaskIntoConstraints = false
		self.imgConstraints = LayoutUtils.layoutFull(v: imgView, parent: self)
		NSLayoutConstraint.activate(self.imgConstraints)
		
		self.label.translatesAutoresizingMaskIntoConstraints = false
		self.labelConstraints = LayoutUtils.layoutFull(v: label, parent: self)
		NSLayoutConstraint.activate(self.labelConstraints)
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

