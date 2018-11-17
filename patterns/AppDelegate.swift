
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

func displayContentController(container:UIViewController, content: UIViewController, frame:CGRect){
	//content.view.frame = frame
	container.view.addSubview(content.view)
	print("content", content, content.view, frame)
	//if let vc = content as? UICollectionViewController {
		//print("contentvc", vc)
		//vc.collectionView?.frame = frame
	//}
	container.addChildViewController(content)
	content.didMove(toParentViewController: container)
	print("add", content, "to", container, "frame", frame)
	print(2,content.view.frame)
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
		// Override point for customization after application launch.
		manager = Manager()
		self.window = UIWindow(frame: UIScreen.main.bounds)
		let nav1 = NavViewController()
		nav1.viewControllers = []
		self.window!.rootViewController = nav1
		self.window?.makeKeyAndVisible()
		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

