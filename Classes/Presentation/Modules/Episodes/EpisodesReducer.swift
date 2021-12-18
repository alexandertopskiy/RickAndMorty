//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture

let episodesReducer = Reducer<EpisodesState, EpisodesAction, EpisodesEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
        if state.data.isEmpty {
            state.seasonsTitles = [L10n.Filters.all]
            state.seasonsNumberArray.forEach { index in
                state.seasonsTitles.append("\(L10n.Episodes.SeasonCode.season) \(index)")
            }
            return environment.apiService.fetchEpisodes(withParameters: state.filterParameters)
                .receive(on: environment.mainQueue)
                .delay(for: .seconds(1), scheduler: environment.mainQueue)
                .catchToEffect()
                .map(EpisodesAction.dataLoaded)
        }
    case .fetchNextPage:
        state.filterParameters.page += 1
        return environment.apiService.fetchEpisodes(withParameters: state.filterParameters)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(EpisodesAction.dataLoaded)
    case .dataLoaded(let result):
        switch result {
        case .success(let episodes):
            episodes.results.forEach { episode in
                print("id #\(episode.id), \(episode.name) (with code \(episode.episodeCode))")
            }
            episodes.results.forEach { episode in
                guard let (_, seasonNumber) = episode.convertedEpisodeCode else {
                    return
                }
                state.seasonsSet.insert(seasonNumber)
            }
            state.filterParameters.totalPages = episodes.info.pages
            state.data += episodes.results
            state.logInfo = nil
            print("number of episodes: \(state.data.count)")
        case .failure(let error):
            print(error.localizedDescription)
            state.logInfo = error
        }
    case .seasonSelected(let index):
        state.selectedSeasonIndex = index
        state.filterParameters.page = 1
        state.filterParameters.totalPages = 0
        state.data.removeAll()
        state.seasonsSet.removeAll()
        if index == 0 {
            state.filterParameters.episode = nil
        } else {
            state.filterParameters.episode = index
        }
        return environment.apiService.fetchEpisodes(withParameters: state.filterParameters)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(EpisodesAction.dataLoaded)
    case .episodeCardSelected(let episode):
        print("episode \(episode.name) selected")
    case .searchInputChanged(let request):
        print("searching episode: \(request ?? "nil")")
        state.filterParameters.name = request
        state.filterParameters.page = 1
        state.filterParameters.totalPages = 0
        state.data.removeAll()
        state.seasonsSet.removeAll()
        return environment.apiService.fetchEpisodes(withParameters: state.filterParameters)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(EpisodesAction.dataLoaded)
    }
    return .none
}
