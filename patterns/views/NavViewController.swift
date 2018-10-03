
import UIKit
import RSClipperWrapper
import ReSwift

class NavViewController: UINavigationController, StoreSubscriber {
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		store.subscribe(self) {
			$0
			.select {
				$0.navigationState
			}
			.skipRepeats()
		}
	}
	
	func getViewController(state: NavState) -> UIViewController{
		if(state == .draw){
			return DesignViewController()
		}
		else if(state == .files){
			return FilesViewController()
		}
		return DesignViewController()
	}
	
	fileprivate func gotoViewController(state: NavState, animated: Bool) {
		let viewController = self.getViewController(state: state)
		self.pushViewController(viewController, animated: animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func newState(state: NavState) {
		print(state)
		let shouldAnimate = self.topViewController != nil
		self.gotoViewController(state: state, animated: shouldAnimate)
	}

}

