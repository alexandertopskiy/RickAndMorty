//
//  Created by Nikita Zatsepilov on 17.10.2019
//  Copyright © 2022 Ronas IT. All rights reserved.
//

import Alamofire
import Foundation
import Networking

extension Endpoint {
    var baseURL: URL {
        guard let serverURL = AppConfiguration.serverURL else {
            fatalError("Server URL must not be nil")
        }
        return serverURL
    }

    var headers: [RequestHeader] {
        return [
            RequestHeaders.acceptJson,
            RequestHeaders.contentJson
        ]
    }

    var parameterEncoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default

        default:
            return JSONEncoding.default
        }
    }
}
