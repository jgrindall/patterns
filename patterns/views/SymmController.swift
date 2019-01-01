
import UIKit
import ReSwift

class SymmController: UIViewController, StoreSubscriber {
	
	required init(){
		super.init(nibName: nil, bundle: nil)
		self.view.frame = CGRect()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .gray
	}
	
	private func down(){
		animateTop(self.view, Constants.SIZE.BUTTON_HEIGHT)
	}
	
	private func up(){
		animateTop(self.view, Constants.SIZE.BUTTON_HEIGHT - self.view.frame.height)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
			.select {
				$0.uiState
			}
			.skipRepeats()
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: UIState) {
		if(state.symm == .hide){
			self.up()
		}
		else{
			self.down()
		}
	}
	
}

