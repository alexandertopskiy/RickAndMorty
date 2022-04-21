//
//  Created by Alexander Loshakov on 07.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation
import Networking

enum EpisodesEndpoint {
    case fetchEpisodes(FetchingParameters)
    case fetchMultipleEpisodes([Int])
}

extension EpisodesEndpoint: Endpoint {
    var path: String {
        switch self {
        case .fetchEpisodes:
            return "api/episode/"
        case let .fetchMultipleEpisodes(ids):
            return "api/episode/\(ids)"
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
        case let .fetchEpisodes(parameters):
            return parameters.convertToDict()
        default:
            return nil
        }
    }

    var authorizationType: AuthorizationType {
        .none
    }
}
