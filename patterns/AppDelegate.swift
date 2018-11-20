
import UIKit
import ReSwift

let loggingMiddleware: Middleware<Any> = { dispatch, getState in
	return { next in
		return { action in
			print("ACTION", action)
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
		UIApplication.shared.isStatusBarHidden = true
		self.window = UIWindow(frame: UIScreen.main.bounds)
		let navController = NavViewController()
		navController.viewControllers = []
		self.window!.rootViewController = navController
		self.window?.makeKeyAndVisible()
		let navigationBarAppearace = UINavigationBar.appearance()
		navigationBarAppearace.tintColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 0.6)
		navigationBarAppearace.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
		navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)]
		
		let customFont = UIFont.appRegularFontWith(size: 17)
		UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedStringKey.font: customFont], for: .normal)
		UITextField.appearance().substituteFontName = "KohinoorDevanagari-Light"
		UILabel.appearance().substituteFontName = "KohinoorDevanagari-Light"
		UILabel.appearance().substituteFontNameBold = "KohinoorDevanagari-Light"

		
		return true
	}
}
