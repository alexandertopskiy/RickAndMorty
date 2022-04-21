//
//  Created by Anton Dityativ on 19.08.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation
import Networking

extension RequestHeaders {
    static var acceptJson: RequestHeaders = .accept("application/json")
    static var contentZip: RequestHeaders = .contentType("application/zip")
    static var contentJson: RequestHeaders = .contentType("application/json")
}
