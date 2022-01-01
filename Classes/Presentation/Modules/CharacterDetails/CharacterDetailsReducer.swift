//
//  Created by Nikita Gavrikov on 12/12/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture

let characterDetailsReducer = Reducer<CharacterDetailsState, CharacterDetailsAction, CharacterDetailsEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
        if state.character.episodes.isEmpty {
            return environment.apiService.fetchMultipleEpisodes(withIds: state.character.episodesIDs)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(CharacterDetailsAction.dataLoaded)
        }
    case .onAppearOrigin:
        return environment.apiServiceLocation.fetchMultipleLocations(withIds: state.character.origin.originID)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(CharacterDetailsAction.dataLoadedOrigin)
    case .dataLoaded(let result):
        switch result {
        case .success(let episodes):
            state.character.episodes += episodes
            print("number of episodes: \(state.character.episodes.count)")
        case .failure(let error):
            print(error.localizedDescription)
        }
    case .dataLoadedOrigin(let result):
        switch result {
        case .success(let location):
            state.character.originLocation += location
            print("count of location: \(state.character.originLocation.count)")
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    return .none
}
