import Foundation
class NewAPI {
	class func makeRequest(url: URL, method: String, body: String? = nil, completion: ((_ result: Data?, Error?) -> Void)?) {
		var request = URLRequest(url: url)
		request.httpMethod = method.uppercased()
		request.httpBody = body?.data(using: .utf8)
		URLSession.shared.dataTask(with: request, completionHandler: { data, _, error in
			completion?(data, error)
		}).resume()
	}
}
