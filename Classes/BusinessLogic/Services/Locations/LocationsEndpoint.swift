//
//  Created by Alexander Loshakov on 07.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation
import Networking

enum LocationsEndpoint {
    case fetchLocations(FetchingParameters)
    case fetchMultipleLocations([Int])
}

extension LocationsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .fetchLocations:
            return "api/location/"
        case let .fetchMultipleLocations(ids):
            return "api/location/\(ids)"
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
        case let .fetchLocations(parameters):
            return parameters.convertToDict()
        default:
            return nil
        }
    }

    var authorizationType: AuthorizationType {
        .none
    }
}
