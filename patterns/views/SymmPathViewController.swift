
import UIKit
import ReSwift

class SymmPathViewController: UIViewController {

	private var symmPathView:SymmPathView = SymmPathView(frame: CGRect())
	private var symmPathConstraints:[NSLayoutConstraint] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.addSubview(self.symmPathView)
		self.initLayout()
	}
	
	func initLayout(){
		self.symmPathConstraints = LayoutUtils.layoutFull(v: self.symmPathView, parent: self.view)
		setupC(children: [symmPathView], constraints: [symmPathConstraints], parent: self.view)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	func newState(state: CodeState) {
		//
	}
	
}
