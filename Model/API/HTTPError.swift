import Foundation
struct HTTPError: Error, LocalizedError {
	let response: URLResponse
	public var errorDescription: String? {
		let httpUrlResponse = response as? HTTPURLResponse
		return HTTPURLResponse.localizedString(forStatusCode: httpUrlResponse?.statusCode ?? 500)
	}
}
