//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

let locationsReducer = Reducer<LocationsState, LocationsAction, LocationsEnvironment> { state, action, environment in
    switch action {
    case .updateData:
        state.locationsData = []
        for card in massiveResult {
            state.locationsData.append(card)
        }
    }
    return .none
}
