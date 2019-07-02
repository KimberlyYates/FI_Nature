import UIKit
import StoreKit
class RateHelper {
	class func openRate() {
		let appID = "1471064891"
		openAppStore(appID: appID)
	}
	class func showRatingPrompt() {
		if #available(iOS 10.3, *) {
			SKStoreReviewController.requestReview()
			analytics.logAction("AskForReview")
		} else {
			analytics.logAction("AskForReview", error: "TooOldVersion")
		}
	}
	private class func openAppStore(appID: String) {
		guard let url = URL(string: "itms-apps://itunes.apple.com/app/id" + appID) else {
			return
		}
		if #available(iOS 10.0, *) {
			UIApplication.shared.open(url, options: [:], completionHandler: nil)
		} else {
			UIApplication.shared.openURL(url)
		}
	}
}
