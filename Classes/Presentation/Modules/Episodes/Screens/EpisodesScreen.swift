//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct EpisodesScreen: View {
    let store: Store<EpisodesState, EpisodesAction>
    @State var isFilterButtonActive: Bool = false

    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                let searchRequest = viewStore.binding(
                    get: {
                        $0.filterParameters.name
                    }, send: {
                        EpisodesAction.searchInputChanged($0)
                    }
                )
                ZStack {
                    Color(Asset.Colors.blackBG.color)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            StickyHeaderComponent(
                                navigationImage: viewStore.state.navigationImage,
                                navigationTitle: viewStore.state.navigationTitle,
                                isFilterHidden: false,
                                searchRequest: searchRequest,
                                isFilterButtonActive: $isFilterButtonActive,
                                store: store
                            )
                            if let logInfo = viewStore.logInfo {
                                Text("\(logInfo.readableInfo)")
                                    .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                                    .foregroundColor(.white)
                                    .kerning(-0.41)
                                    .padding(.top, Layout.scaleFactorH * 150)
                                    .padding(.horizontal, Layout.scaleFactorW * 24)
                                    .multilineTextAlignment(.center)
                            } else {
                                if viewStore.data.isEmpty {
                                    AnimationViewComponent()
                                        .frame(width: Layout.scaleFactorW * 50, height: Layout.scaleFactorW * 50)
                                        .padding(.top, Layout.scaleFactorH * 150)
                                } else {
                                    EpisodesScrollView(store: store)
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
            }
            .navigationBarHidden(true)
        }
    }
}

struct EpisodesScreen_Previews: PreviewProvider {
    static var previews: some View {
        EpisodesScreen(
            store: Store(
                initialState: EpisodesState(),
                reducer: episodesReducer,
                environment: EpisodesEnvironment(
                    apiService: ServiceContainer().episodesService,
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            )
        )
    }
}
