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
                locations.results.forEach { location in
                    print("id #\(location.id), \(location.name) (with type \(location.type.rawValue))")
                }
                state.filterParameters.totalPages = locations.info.pages
                state.data += locations.results
                state.logInfo = nil
                print("number of locations: \(state.data.count)")
            case .failure(let error):
                print(error.localizedDescription)
                state.logInfo = error
            }
        case .locationCardSelected(let location):
            print("location \(location.name) selected")
        case .searchInputChanged(let request):
            print("searching location: \(request ?? "nil")")
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
        }
        return .none
    },

    filterReducer.pullback(state: \.filter, action: /LocationsAction.filter) { _ in
        FilterEnvironment()
    }
)
