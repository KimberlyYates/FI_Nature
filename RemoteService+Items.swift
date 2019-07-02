import Foundation
extension RemoteService {
	func fetchItems(_ category: String, completion: @escaping (Result<[Item], Error>) -> Void) {
		makeRequest(String(format: "/categories/%@/items", category),
					method: .get,
					body: nil,
					responseType: [Item].self,
					cacheName: String(format: "Items:%@", category),
					completion: completion)
	}
}
