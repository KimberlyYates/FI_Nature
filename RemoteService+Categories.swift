import Foundation
extension RemoteService {
	func fetchCategories(_ country: String?, completion: @escaping (Result<[Category], Error>) -> Void) {
		makeRequest(String(format: "/categories/%@", country ?? ""),
					method: .get,
					body: nil,
					responseType: [Category].self,
					cacheName: String(format: "Categories:%@", country ?? ""),
					completion: completion)
	}
}
