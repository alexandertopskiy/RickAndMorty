//
//  Created by Nikita Gavrikov on 12/12/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture

let episodeDetailsReducer = Reducer<EpisodeDetailsState, EpisodeDetailsAction, EpisodeDetailsEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
        if state.episode.characters.isEmpty {
            return environment.apiService.fetchMultipleCharacters(withIds: state.episode.charactersIDs)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(EpisodeDetailsAction.dataLoaded)
        }
    case .dataLoaded(let result):
        switch result {
        case .success(let characters):
            state.episode.characters += characters
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    return .none
}
