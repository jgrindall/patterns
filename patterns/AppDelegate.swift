
import UIKit
import ReSwift

let loggingMiddleware: Middleware<Any> = { dispatch, getState in
	return { next in
		return { action in
			// perform middleware logic
			//print("ACTION", action)
			// call next middleware
			return next(action)
		}
	}
}

var store:Store = Store<AppState>(reducer: appReducer, state: AppState(), middleware: [loggingMiddleware])

var manager:Manager?

func displayContentController(container:UIViewController, content: UIViewController){
	container.view.addSubview(content.view)
	container.addChildViewController(content)
	content.didMove(toParentViewController: container)
}

func hideContentController(container:UIViewController, content: UIViewController) {
	content.willMove(toParentViewController: nil)
	content.view.removeFromSuperview()
	content.removeFromParentViewController()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		manager = Manager()
		self.window = UIWindow(frame: UIScreen.main.bounds)
		let navController = NavViewController()
		navController.viewControllers = []
		self.window!.rootViewController = navController
		self.window?.makeKeyAndVisible()
		return true
	}

}

