
import UIKit
import ReSwift

class DetailViewController: UIViewController {
	
	private var imgView:UIImageView = UIImageView(frame: CGRect())
	private var imgConstraints:[NSLayoutConstraint] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.clear
		self.view.addSubview(imgView)
		self.initLayout()
	}
	
	func initLayout(){
		self.imgConstraints = LayoutUtils.layoutFull(v: self.imgView, parent: self.view)
		setupC(
			children: [
				imgView
			],
			constraints: [
				imgConstraints
			],
			parent: self.view
		)
	}
	
	func loadFile(f:FileModel){
		print("file", f);
		self.imgView.image = UIImage(named: f.imageSrc)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}

}

