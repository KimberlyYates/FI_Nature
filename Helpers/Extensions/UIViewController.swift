import UIKit
import SafariServices
extension UIViewController {
	func openURL(_ url: URL, modally: Bool) {
		if modally {
			let safariViewController = SFSafariViewController(url: url)
			present(safariViewController, animated: true, completion: nil)
		} else {
			if #available(iOS 10.0, *) {
				UIApplication.shared.open(url, options: [:], completionHandler: nil)
			} else {
				UIApplication.shared.openURL(url)
			}
		}
	}
}
