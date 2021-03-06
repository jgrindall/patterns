
import UIKit
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
		if(state == .design){
			return DesignViewController()
		}
		else if(state == .files){
			return FilesViewController()
		}
		return DesignViewController()
	}
	
	fileprivate func gotoViewController(state: NavState, animated: Bool) {
		let c:String = self.getVisibleName()
		if(c == state.rawValue){
			return
		}
		let viewController = self.getViewController(state: state)
		self.pushViewController(viewController, animated: animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		store.unsubscribe(self)
	}
	
	func getVisibleName()->String{
		if(self.visibleViewController == nil){
			return ""
		}
		let page = self.visibleViewController as! PPageViewController
		return page.getName()
	}
	
	func newState(state: NavState) {
		let shouldAnimate = self.topViewController != nil
		self.gotoViewController(state: state, animated: shouldAnimate)
	}

}


extension NavViewController: UINavigationBarDelegate  {
	
	public func navigationBar(_ navigationBar: UINavigationBar, didPop item: UINavigationItem) {
		let page = self.visibleViewController as! PPageViewController
		if(page.getName() == "files"){
			store.dispatch(NavigateAction(payload: .files))
		}
		else if(page.getName() == "design"){
			store.dispatch(NavigateAction(payload: .design))
		}
		//let newRoute = Array(store.state.navigationState.route.dropLast())
		//let routeAction = ReSwiftRouter.SetRouteAction(newRoute)
		//store.dispatch(routeAction)
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
	
}

