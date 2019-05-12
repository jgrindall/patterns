
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

var s:AppState = AppState()

var store:Store = Store<AppState>(reducer: appReducer, state:s)

//var store:Store = Store<AppState>(reducer: appReducer, state: AppState(), middleware: [loggingMiddleware])

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

func positionTopLeft(_ view:UIView, _ top:CGFloat, _ left:CGFloat){
	let c1:NSLayoutConstraint? = getC(view, NSLayoutAttribute.leading)
	if(c1 != nil){
		c1?.constant = left
	}
	let c2:NSLayoutConstraint? = getC(view, NSLayoutAttribute.top)
	if(c2 != nil){
		c2?.constant = top
	}
}

func positionLeft(_ view:UIView, _ left:CGFloat){
	let c:NSLayoutConstraint? = getC(view, NSLayoutAttribute.leading)
	if(c != nil){
		c?.constant = left
	}
}

func positionTop(_ view:UIView, _ top:CGFloat){
	let c:NSLayoutConstraint? = getC(view, NSLayoutAttribute.top)
	if(c != nil){
		c?.constant = top
	}
}

func animateLeft(_ view:UIView, _ left:CGFloat){
	let c:NSLayoutConstraint? = getC(view, NSLayoutAttribute.leading)
	if(c != nil){
		c?.constant = left
		UIView.animate(withDuration: Constants.ANIM.ANIM_TIME, animations: {
			view.superview?.layoutIfNeeded()
		}, completion: nil)
	}
}

func animateTop(_ view:UIView, _ top:CGFloat){
	let c:NSLayoutConstraint? = getC(view, NSLayoutAttribute.top)
	if(c != nil){
		c?.constant = top
		UIView.animate(withDuration: Constants.ANIM.ANIM_TIME, animations: {
			view.superview?.layoutIfNeeded()
		}, completion: nil)
	}
}

func animateBottom(_ view:UIView, _ bottom:CGFloat){
	let c:NSLayoutConstraint? = getC(view, NSLayoutAttribute.bottom)
	if(c != nil){
		c?.constant = bottom
		UIView.animate(withDuration: Constants.ANIM.ANIM_TIME, animations: {
			view.superview?.layoutIfNeeded()
		}, completion: nil)
	}
}

func getC(_ child:UIView, _ type:NSLayoutAttribute) -> NSLayoutConstraint?{
	let con:[NSLayoutConstraint] = (child.superview?.constraints)!
	for c:NSLayoutConstraint in con{
		if((c.firstItem as! UIView == child) && c.firstAttribute.rawValue == type.rawValue){
			return c
		}
	}
	return nil
}

func setupC(children:[UIView], constraints:[[NSLayoutConstraint]], parent:UIView){
	assert(children.count == constraints.count)
	for constraint in parent.constraints{
		parent.removeConstraint(constraint)
	}
	for child in children{
		child.translatesAutoresizingMaskIntoConstraints = false
	}
	for con:[NSLayoutConstraint] in constraints{
		parent.addConstraints(con)
		NSLayoutConstraint.activate(con)
	}
	assert(parent.constraints.count == 4*children.count)
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		manager = Manager()
		UIApplication.shared.isStatusBarHidden = true
		self.window = UIWindow(frame: UIScreen.main.bounds)
		let navController = NavViewController()
		Constants.SIZE.CONFIG_MARKER_SIZE = navController.navigationBar.frame.size.height - 2
		print(navController.navigationBar.frame.size.height)
		navController.viewControllers = []
		navController.navigationBar.shadowImage = UIImage()
		
		navController.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navController.navigationBar.isTranslucent = true
		
		for subview in navController.navigationBar.subviews {
			for child in subview.subviews {
				if(child is UIImageView) {
					child.removeFromSuperview()
				}
			}
		}
		
		self.window!.rootViewController = navController
		self.window?.makeKeyAndVisible()
		let navigationBarAppearace = UINavigationBar.appearance()
		navigationBarAppearace.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
		navigationBarAppearace.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
		navigationBarAppearace.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)]
		navigationBarAppearace.setBackgroundImage(UIImage.pixelWithColor(color: Constants.COLORS.BG_COLOR), for: .default)

		return true
	}
}
