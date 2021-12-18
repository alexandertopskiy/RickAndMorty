//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct CharactersScreen: View {
    let store: Store<CharactersState, CharactersAction>

    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                let isFilterPresented = viewStore.binding(
                    get: {
                        $0.isFilterPresented
                    },
                    send: { _ in
                        CharactersAction.filter(.onDisappear)
                    }
                )
                let isFilterButtonActive = viewStore.binding(
                    get: {
                        $0.isFilterButtonActive
                    },
                    send: { _ in
                        CharactersAction.filterButtonTapped
                    }
                )
                let searchRequest = viewStore.binding(
                    get: {
                        $0.filterParameters.name
                    },
                    send: {
                        CharactersAction.searchInputChanged($0)
                    }
                )
                ZStack {
                    Color(Asset.Colors.blackBG.color)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            StickyHeaderComponent(
                                navigationImage: viewStore.state.navigationImage,
                                navigationTitle: viewStore.state.navigationTitle,
                                isFilterHidden: true,
                                searchRequest: searchRequest,
                                isFilterButtonActive: isFilterButtonActive,
                                store: nil
                            )
                            if let logInfo = viewStore.logInfo {
                                Text("\(logInfo.readableInfo)")
                                    .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                                    .foregroundColor(.white)
                                    .kerning(-0.41)
                                    .padding(.top, Layout.scaleFactorH * 150)
                            } else {
                                if viewStore.data.isEmpty {
                                    AnimationViewComponent()
                                        .frame(width: Layout.scaleFactorW * 50, height: Layout.scaleFactorW * 50)
                                        .padding(.top, Layout.scaleFactorH * 150)
                                } else {
                                    CharactersScrollView(store: store)
                                        .padding(.vertical, Layout.scaleFactorH * 16)
                                        .zIndex(0)
                                }
                            }
                        }.keyboardResponsive()
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

extension CharactersScreen {
    private var filterStore: Store<FilterState, FilterAction> {
        return store.scope(
            state: {
                $0.filter
            },
            action: CharactersAction.filter
        )
    }
}

struct CharactersScreen_Previews: PreviewProvider {
    static var previews: some View {
        CharactersScreen(
            store: Store(
                initialState: CharactersState(),
                reducer: charactersReducer,
                environment: CharactersEnvironment(
                    apiService: ServiceContainer().charactersService,
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            )
        )
    }
}
