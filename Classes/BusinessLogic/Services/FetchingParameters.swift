//
//  Created by Alexander Loshakov on 11.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import Foundation

struct FetchingParameters: Equatable {
    // MARK: - Common params
    var page: Int = 1
    var type: String?
    var name: String?

    // MARK: - Character
    var status: String? // Alive, Dead, Unknown
    var species: String?
    var gender: String? // Female, Male, Genderless, Unknown

    // MARK: - Locations
    var dimension: String?

    // MARK: - Episodes
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
            filter["episode"] = "S0\(episode)"
        }
        return filter
    }
}
