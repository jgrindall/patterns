
import UIKit
import ReSwift

class DetailViewController: UIViewController {
	
	private var imgView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = UIColor.red
	}
	
	func loadFile(f:FileModel){
		print("file", f);
		self.imgView.image = UIImage(named: f.imageSrc)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.view.addSubview(imgView)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}

}

