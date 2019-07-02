import UIKit
extension UIApplication {
	var appVersion: String {
		return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
	}
	var appBuild: String {
		return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
	}
	var formattedVersion: String {
		return appVersion + " (" + appBuild + ")"
	}
}
