
import UIKit
import ReSwift

class ListItemView: UIView {
	
	private var imgView = UIImageView(frame: CGRect())
	private var imgConstraints:[NSLayoutConstraint] = []
	private var label = UILabel(frame:CGRect())
	private var labelConstraints:[NSLayoutConstraint] = []
	
	init(frame: CGRect, model:ListItemModel) {
		super.init(frame: frame)
		self.layer.cornerRadius = Constants.SIZE.DRAG_SIZE/2
		self.backgroundColor = model.clr
		imgView.image = UIImage(named: model.imageSrc)
		label.text = model.content
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


