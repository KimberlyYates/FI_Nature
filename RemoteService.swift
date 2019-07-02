import Foundation
import UIKit
class RemoteService {
	private init() {}
	static let shared = RemoteService()
	private let baseUrl = "https://eaststudios.net/api/nature"
	func makeRequest<T: Codable>(_ path: String,
								   method: HTTPMethod,
								   body: RequestBody?,
								   responseType: T.Type,
								   cacheName: String?,
								   completion: @escaping (Result<T, Error>) -> Void) {
		guard let url = URL(string: baseUrl + path) else {
			completion(.failure(ErrorResponse.unknown))
			return
		}
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue.uppercased()
		self.addHeaders(to: &request, body: body)
		URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
			let cachedResult: T? = cacheName != nil ? Storage.retrieve(cacheName!, from: .caches, as: responseType) : nil
			guard let data = data, let response = response, error == nil else {
				if let cachedResult = cachedResult {
					completion(.success(cachedResult))
				} else {
					completion(.failure(error ?? ErrorResponse.unknown))
				}
				return
			}
			if let error = self.decodeError(from: data, response: response) {
				if let cachedResult = cachedResult {
					completion(.success(cachedResult))
				} else {
					completion(.failure(error))
				}
				return
			}
			let decoder = JSONDecoder()
			if #available(iOS 10.0, *) {
				decoder.dateDecodingStrategy = .iso8601
			} else {
				let dateFormatter = DateFormatter()
				let enUSPosixLocale = Locale(identifier: "en_US_POSIX")
				dateFormatter.locale = enUSPosixLocale
				dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
				dateFormatter.calendar = Calendar(identifier: .gregorian)
				decoder.dateDecodingStrategy = .formatted(dateFormatter)
			}
			do {
				let result = try decoder.decode(responseType, from: data)
				if let name = cacheName {
					Storage.store(result, to: .caches, as: name)
				}
				completion(.success(result))
			} catch {
				if let cachedResult = cachedResult {
					completion(.success(cachedResult))
				} else {
					completion(.failure(error))
				}
			}
		}).resume()
	}
	private func addHeaders(to request: inout URLRequest, body: RequestBody?) {
		if let body = body {
			switch body {
			case .dictionary(let dictionary):
				request.httpBody = try? JSONSerialization.data(withJSONObject: dictionary)
				request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			case .data(let data, let contentType):
				request.httpBody = data
				if let contentType = contentType {
					request.setValue(contentType, forHTTPHeaderField: "Content-Type")
				}
			}
		}
		let headers: [String: String] = [
			"X-Api-Version": "3",
			"X-Api-Key": "6c2bcfe0-862e-4564-8d5b-8110397306e2",
			"X-App-Version": "1021",
			"X-App-ID": "com.eaststudios.natureguide"
		]
		for (key, value) in headers {
			request.setValue(value, forHTTPHeaderField: key)
		}
	}
	private func decodeError(from data: Data, response: URLResponse) -> Error? {
		let httpUrlResponse = response as? HTTPURLResponse
		let statusCode = httpUrlResponse?.statusCode ?? 500
		if statusCode < 400 {
			return nil
		}
		if let error = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
			return error
		}
		return HTTPError(response: response)
	}
	enum HTTPMethod: String {
		case get
		case post
		case put
		case delete
	}
	enum RequestBody {
		case dictionary([String: Any])
		case data(Data, contentType: String?)
	}
}
