//
//  Created by Alexander Loshakov on 07.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation

enum NetworkError: Equatable, Error {
    case unexpected(Error)
    case decoding(Error)
    case network(Error)
    case statusCode(Int)
    case nonHTTPResponse

    var string: String {
        return String(reflecting: self)
    }

    var readableInfo: String {
        switch self {
        case let .statusCode(code) where code == 404:
            return L10n.Log.notFound

        default:
            return L10n.Log.error
        }
    }

    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        guard type(of: lhs) == type(of: rhs) else {
            return false
        }
        return lhs.string == rhs.string
    }

    static func map(_ error: Error) -> NetworkError {
        switch error {
        case let decodingError as DecodingError:
            return NetworkError.decoding(decodingError)

        default:
            return (error as? NetworkError) ?? .unexpected(error)
        }
    }
}
