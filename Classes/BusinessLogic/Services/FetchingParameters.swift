//
//  Created by Alexander Loshakov on 11.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation

struct FetchingParameters: Equatable {
    var page: Int = 1
    var totalPages: Int = 0
    var type: String?
    var name: String?
    var status: String?
    var species: String?
    var gender: String?
    var dimension: String?
    var episode: Int?

    func convertToDict() -> [String: Any] {
        var filter = [String: Any]()
        filter["page"] = "\(self.page)"
        if let type = self.type {
            filter["type"] = "\(type)"
        }
        if let name = self.name {
            filter["name"] = "\(name)"
        }
        if let status = self.status {
            filter["status"] = "\(status)"
        }
        if let species = self.species {
            filter["species"] = "\(species)"
        }
        if let gender = self.gender {
            filter["gender"] = "\(gender)"
        }
        if let dimension = self.dimension {
            filter["dimension"] = "\(dimension)"
        }
        if let episode = self.episode {
            filter["episode"] = episode / 10 == 0 ? "S0\(episode)" : "S\(episode)"
        }
        return filter
    }
}
