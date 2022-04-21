//
//  Created by Alexander Loshakov on 07.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation
import Networking

enum CharactersEndpoint {
    case fetchCharacters(FetchingParameters)
    case fetchMultipleCharacters([Int])
}

extension CharactersEndpoint: Endpoint {
    var path: String {
        switch self {
        case .fetchCharacters:
            return "api/character/"
        case let .fetchMultipleCharacters(ids):
            return "api/character/\(ids)"
        }
    }

    var method: HTTPMethod {
        return .get
    }

    var headers: [RequestHeader] {
        return [RequestHeaders.contentJson]
    }

    var parameters: Parameters? {
        switch self {
        case let .fetchCharacters(parameters):
            return parameters.convertToDict()
        default:
            return nil
        }
    }

    var authorizationType: AuthorizationType {
        .none
    }
}
