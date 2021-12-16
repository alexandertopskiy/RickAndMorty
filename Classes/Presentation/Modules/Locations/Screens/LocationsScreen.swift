//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct LocationsScreen: View {
    let store: Store<LocationsState, LocationsAction>

    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                let isFilterPresented = viewStore.binding(
                    get: {
                        $0.isFilterPresented
                    },
                    send: { _ in
                        LocationsAction.filter(.onDisappear)
                    }
                )
                let isFilterButtonActive = viewStore.binding(
                    get: {
                        $0.isFilterButtonActive
                    },
                    send: { _ in
                        LocationsAction.filterButtonTapped
                    }
                )
                let searchRequest = viewStore.binding(
                    get: {
                        $0.filterParameters.name ?? ""
                    }, send: {
                        LocationsAction.searchInputChanged($0)
                    }
                )
                ZStack {
                    Color(Asset.Colors.blackBG.name)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            StickyHeaderComponent(
                                navigationImage: viewStore.state.navigationImage,
                                navigationTitle: viewStore.state.navigationTitle,
                                isFilterHidden: true,
                                searchRequest: searchRequest,
                                isFilterButtonActive: isFilterButtonActive
                            )
                            if viewStore.data.isEmpty {
                                ProgressView()
                                    .padding(.top, Layout.scaleFactorH * 150)
                            } else {
                                LazyVStack(spacing: 16) {
                                    ForEach(viewStore.state.data, id: \.id) { card in
                                        NavigationLink {
                                            DetailsHelloComponent()
                                        } label: {
                                            LocationsCardComponent(locationDetail: card)
                                        }
                                    }
                                    if viewStore.filterParameters.page < viewStore.filterParameters.totalPages {
                                        ProgressView().onAppear {
                                            viewStore.send(.fetchNextPage)
                                        }
                                    }
                                }
                                .padding(.vertical, Layout.scaleFactorH * 16)
                                .zIndex(0)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    viewStore.send(.onAppear)
                }
                .sheet(
                    isPresented: isFilterPresented,
                    onDismiss: {
                        viewStore.send(.filterSettingsChanged)
                    },
                    content: {
                        FilterScreen(store: self.filterStore)
                    }
                )
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: -  Getting store of filter

extension LocationsScreen {
    private var filterStore: Store<FilterState, FilterAction> {
        return store.scope(
            state: {
                $0.filter
            },
            action: LocationsAction.filter
        )
    }
}

struct LocationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationsScreen(
            store: Store(
                initialState: LocationsState(),
                reducer: locationsReducer,
                environment: LocationsEnvironment(
                    apiService: ServiceContainer().locationsService,
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            )
        )
    }
}
