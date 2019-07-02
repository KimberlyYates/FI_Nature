import Foundation
extension RemoteService {
	func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
		makeRequest("/countries",
					method: .get,
					body: nil,
					responseType: [Country].self,
					cacheName: "Countries",
					completion: completion)
	}
}
