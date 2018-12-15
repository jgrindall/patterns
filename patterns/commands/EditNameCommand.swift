import UIKit

class EditNameCommand {
	
	init(text:String, delegate : PEditNameDelegate, parentViewController:UIViewController) {
		let editor = EditNameViewController(text)
		editor.delegate = delegate
		editor.preferredContentSize = CGSize(width: 500, height: 500)
		editor.modalPresentationStyle = .popover
		let popover = editor.popoverPresentationController
		popover?.sourceView = parentViewController.view
		popover?.sourceRect = parentViewController.view.frame
		parentViewController.present(editor, animated: true, completion: nil)
	}
	
}
