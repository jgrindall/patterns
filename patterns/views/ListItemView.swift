
import UIKit
import ReSwift

class ListItemView: UIView {
	private var imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
	
	init(frame: CGRect, model:ListItemModel) {
		super.init(frame: frame)
		self.layer.cornerRadius = 30
		self.backgroundColor = model.clr
		imgView.image = UIImage(named: model.imageSrc)
		self.addSubview(imgView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


