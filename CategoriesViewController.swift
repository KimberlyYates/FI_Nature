import UIKit
class CategoriesViewController: BaseViewController {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	override func setInterfaceStrings() {
		super.setInterfaceStrings()
		title = "categories.title".localized
	}
	override func setupViews() {
		super.setupViews()
		registerForPreviewing(with: self, sourceView: tableView)
		tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
		if #available(iOS 10.0, *) {
			tableView.refreshControl = refreshControl
		} else {
			tableView.addSubview(refreshControl)
		}
		let settingsButton = UIBarButtonItem(image: UIImage(named: "categories.button.settings"), style: .plain, target: self, action: #selector(toSettings))
		navigationItem.leftBarButtonItem = settingsButton
	}
	override func updateTheme() {
		super.updateTheme()
		view.backgroundColor = Theme.current.viewBackgroundColor
		tableView.backgroundColor = Theme.current.viewBackgroundColor
		tableView.reloadData()
	}
	override func reloadData() {
		super.reloadData()
		let country = UserDefaults.standard.string(forKey: "Country")
		refreshControl.beginRefreshing()
		RemoteService.shared.fetchCategories(country, completion: { result in
			DispatchQueue.main.async {
				self.refreshControl.endRefreshing()
				switch result {
				case .success(let result):
					self.categories = result
					self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
				case .failure(let error):
					self.presentError(error)
				}
				UserDefaults.standard.set(false, forKey: "ForceRefreshData")
			}
		})
	}
	@objc func toSettings() {
		let settingsViewController = SettingsViewController()
		let navigationController = UINavigationController(rootViewController: settingsViewController)
		settingsViewController.addDoneButton()
		present(navigationController, animated: true)
	}
	func viewController(for indexPath: IndexPath) -> UIViewController {
		let itemsViewController = ItemsViewController(category: categories[indexPath.row])
		return itemsViewController
	}
	var categories = [Category]()
	@IBOutlet var tableView: UITableView!
}
extension CategoriesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		navigationController?.pushViewController(viewController(for: indexPath), animated: true)
	}
}
extension CategoriesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return categories.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
			return UITableViewCell()
		}
		let category = categories[indexPath.row]
		cell.categoryNameLabel.text = category.name
		cell.countLabel.text = String(format: "categories.items.%i".localized, category.itemCount)
		cell.categoryImageView.image = category.image
		cell.backgroundColor = category.color
		cell.tintColor = category.useLightText ? Theme.dark.textColor : Theme.light.textColor
		cell.categoryNameLabel.textColor = category.useLightText ? Theme.dark.textColor : Theme.light.textColor
		cell.countLabel.textColor = category.useLightText ? .groupTableViewBackground : .darkGray
		return cell
	}
}
extension CategoriesViewController: UIViewControllerPreviewingDelegate {
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
		if let indexPath = tableView.indexPathForRow(at: location) {
			previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
			return viewController(for: indexPath)
		}
		return nil
	}
	func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
		navigationController?.pushViewController(viewControllerToCommit, animated: true)
	}
}
