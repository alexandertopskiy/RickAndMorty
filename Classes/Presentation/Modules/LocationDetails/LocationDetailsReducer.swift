//
//  Created by Nikita Gavrikov on 12/12/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture

let locationDetailsReducer = Reducer<LocationDetailsState, LocationDetailsAction, LocationDetailsEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
        if state.location.residents.isEmpty {
            return environment.apiService.fetchMultipleCharacters(withIds: state.location.residentsIDs)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(LocationDetailsAction.dataLoaded)
        }
    case .dataLoaded(let result):
        switch result {
        case .success(let residents):
            state.location.residents += residents
            print("number of residents: \(state.location.residents.count)")
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    return .none
}
