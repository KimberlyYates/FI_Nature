import UIKit
class BaseViewController: UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		UserDefaults.standard.addObserver(self, forKeyPath: "UseDarkTheme", options: .new, context: nil)
		setupViews()
		reloadData()
		setInterfaceStrings()
		saveAnalytics()
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateTheme()
	}
	init() {
		super.init(nibName: String(describing: type(of: self)), bundle: nil)
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	deinit {
		UserDefaults.standard.removeObserver(self, forKeyPath: "UseDarkTheme")
	}
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == "UseDarkTheme" {
			updateTheme()
		}
	}
	func setInterfaceStrings() {}
	func setupViews() {
		refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
	}
	func updateTheme() {
		navigationController?.navigationBar.barStyle = Theme.current.barStyle
		navigationController?.toolbar.barStyle = Theme.current.barStyle
		isThemeSet = true
	}
    @objc func reloadData() {}
	func saveAnalytics() {
		analytics.logAction("OpenView", data1: String(describing: type(of: self)))
	}
	func addDoneButton() {
		let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
		if navigationItem.rightBarButtonItems?.isEmpty ?? true {
			navigationItem.rightBarButtonItem = doneButton
		} else {
			navigationItem.rightBarButtonItems?.append(doneButton)
		}
	}
	@objc func done() {
		dismiss(animated: true, completion: nil)
	}
	override func present(_ viewControllerToPresent: UIViewController,
						  animated flag: Bool,
						  completion: (() -> Void)? = nil) {
		if viewControllerToPresent is UINavigationController {
			if #available(iOS 11.0, *) {
				(viewControllerToPresent as? UINavigationController)?.navigationBar.prefersLargeTitles = true
			}
		}
		super.present(viewControllerToPresent, animated: flag, completion: completion)
	}
	func presentError(_ error: Error?, actions: [UIAlertAction] = [], showDimissButton: Bool = true) {
		guard let error = error else {
			return
		}
		#if DEBUG
		let errorText = (error as NSError).description
		#else
		let errorText = error.localizedDescription
		#endif
		showAlert(title: "alert.title.error".localized, message: errorText,
				  actions: actions, addDimissButton: showDimissButton)
	}
	func showAlert(title: String, message: String? = nil, actions: [UIAlertAction] = [], addDimissButton: Bool = true) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		for action in actions {
			alert.addAction(action)
		}
		if addDimissButton {
			alert.addOKAction()
		}
		DispatchQueue.main.async {
			self.present(alert, animated: true, completion: nil)
		}
	}
	var isThemeSet = false
	var refreshControl = UIRefreshControl()
}
