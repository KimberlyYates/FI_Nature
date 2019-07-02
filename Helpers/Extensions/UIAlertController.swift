import UIKit
extension UIAlertController {
	func addCancelAction() {
		addAction(with: "alert.button.cancel".localized)
	}
	func addOKAction() {
		addAction(with: "alert.button.ok".localized)
	}
	private func addAction(with title: String) {
		let action = UIAlertAction(title: title, style: .cancel, handler: nil)
		addAction(action)
	}
}
