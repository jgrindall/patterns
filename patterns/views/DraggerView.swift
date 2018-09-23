
import UIKit

class DraggerView : UIView{

	override init(frame:CGRect){
		super.init(frame: frame)
		self.backgroundColor = UIColor.red
		self.layer.cornerRadius = 25
		self.layer.masksToBounds = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
