//
//  Created by Alexander Loshakov on 07.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation
import Combine
import ComposableArchitecture
import Networking

func makeRequest(_ endpoint: @escaping () -> Endpoint) -> URLRequest {
    var request = URLRequest(url: endpoint().url)
    request.method = endpoint().method
    request.headers = endpoint().headers.httpHeaders
    guard let params = endpoint().parameters else {
        return request
    }

    var requestWithParams: URLRequest
    guard var components = URLComponents(url: endpoint().url, resolvingAgainstBaseURL: true) else {
        return request
    }
    let queryItems = params.map { parameter in
        URLQueryItem(name: parameter.key, value: parameter.value as? String)
    }
    components.queryItems = queryItems
    guard let url = components.url else {
        return request
    }
    requestWithParams = URLRequest(url: url)
    requestWithParams.method = endpoint().method
    requestWithParams.headers = endpoint().headers.httpHeaders
    requestWithParams.cachePolicy = .reloadRevalidatingCacheData

    return requestWithParams
}

func requestWithEffect<T: Codable>(_ request: URLRequest) -> Effect<T, NetworkError> {
    URLSession.shared.dataTaskPublisher(for: request)
        .tryMap { response in
            // Check that the response is an HTTP response
            guard
                let httpResponse = response.response as? HTTPURLResponse
            else {
                throw NetworkError.nonHTTPResponse
            }

            let statusCode = httpResponse.statusCode

            // Check that the response from the server has returned with a successful status
            guard
                (200 ..< 300).contains(statusCode)
            else {
                throw NetworkError.statusCode(statusCode)
            }

            // Try deserializing data into a model
            return try JSONDecoder().decode(T.self, from: response.data)
        }
        // Convert Error to NetworkError
        .mapError {
            NetworkError.map($0)
        }
        .eraseToAnyPublisher()
        .eraseToEffect()
}
