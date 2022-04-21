//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture

let locationsReducer: Reducer<LocationsState, LocationsAction, LocationsEnvironment> = .combine(
    .init { state, action, environment in
        switch action {
        case .onAppear:
            if state.data.isEmpty {
                return environment.apiService.fetchLocations(withParameters: state.filterParameters)
                    .receive(on: environment.mainQueue)
                    .delay(for: .seconds(1), scheduler: environment.mainQueue)
                    .catchToEffect()
                    .map(LocationsAction.dataLoaded)
            }
        case .fetchNextPage:
            state.filterParameters.page += 1
            return environment.apiService.fetchLocations(withParameters: state.filterParameters)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(LocationsAction.dataLoaded)
        case .dataLoaded(let result):
            switch result {
            case .success(let locations):
                state.filterParameters.totalPages = locations.info.pages
                state.data += locations.results
                state.logInfo = nil
            case .failure(let error):
                state.logInfo = error
            }
        case .locationCardSelected(let location):
            state.details.location = location
        case .searchInputChanged(let request):
            state.filterParameters.name = request
            state.filterParameters.page = 1
            state.filterParameters.totalPages = 0
            state.data.removeAll()
            return environment.apiService.fetchLocations(withParameters: state.filterParameters)
                .receive(on: environment.mainQueue)
                .catchToEffect()
                .map(LocationsAction.dataLoaded)
        case .filterSettingsChanged:
            let appliedFilters = state.filter.filterParameters
            switch (appliedFilters.type, appliedFilters.dimension) {
            case (nil, nil):
                state.isFilterButtonActive = false
            default:
                state.isFilterButtonActive = true
            }
            state.filterParameters = state.filter.filterParameters
            state.data.removeAll()
            return environment.apiService.fetchLocations(withParameters: state.filterParameters)
                .receive(on: environment.mainQueue)
                .delay(for: .seconds(1), scheduler: environment.mainQueue)
                .catchToEffect()
                .map(LocationsAction.dataLoaded)
        case .filter(let action):
            switch action {
            case .applyFilter, .onDisappear:
                state.isFilterPresented = false
            default:
                break
            }
        case .filterButtonTapped:
            state.isFilterPresented = true
            state.filterParameters.page = 1
            state.filterParameters.totalPages = 0
            state.filter.filterParameters = state.filterParameters
        case .details:
            break
        }
        return .none
    },

    filterReducer.pullback(state: \.filter, action: /LocationsAction.filter) { _ in
        FilterEnvironment()
    },
    locationDetailsReducer.pullback(state: \.details, action: /LocationsAction.details) { _ in
        LocationDetailsEnvironment(
            apiService: ServiceContainer().charactersService,
            mainQueue: DispatchQueue.main.eraseToAnyScheduler()
        )
    }
)
