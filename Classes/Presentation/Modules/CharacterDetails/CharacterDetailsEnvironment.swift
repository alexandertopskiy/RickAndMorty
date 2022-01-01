//
//  Created by Nikita Gavrikov on 12/12/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture

struct CharacterDetailsEnvironment {
    var apiService: EpisodesServiceProtocol
    var apiServiceLocation: LocationsServiceProtocol
    var mainQueue: AnySchedulerOf<DispatchQueue>
}
