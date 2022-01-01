//
//  Created by Nikita Gavrikov on 12/12/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct LocationDetailsScreen: View {
    let store: Store<LocationDetailsState, LocationDetailsAction>
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                Color(Asset.Colors.blackBG.name)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 0) {
                        LocationDetailsHeaderView(location: viewStore.location)
                            .padding(.top, Layout.scaleFactorH * 108)
                        LocationDetailsInfoView(location: viewStore.location)
                            .padding(.top, 24)
                        if !viewStore.location.residents.isEmpty {
                            HStack {
                                Text(L10n.Details.Location.scrollTitle)
                                    .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                                    .foregroundColor(.white)
                                    .frame(height: 22)
                                Spacer()
                            }
                            .padding(.top, 24)
                            .padding(.leading, Layout.scaleFactorW * 24)
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewStore.location.residents, id: \.id) { resident in
                                    NavigationLink {
                                        CharacterDetailsScreen(
                                            store: Store(
                                                initialState: CharacterDetailsState(character: resident),
                                                reducer: characterDetailsReducer,
                                                environment: CharacterDetailsEnvironment(
                                                    apiService: ServiceContainer().episodesService,
                                                    apiServiceLocation: ServiceContainer().locationsService,
                                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                                )
                                            )
                                        )
                                    } label: {
                                        CharacterCard(сharacter: resident)
                                    }
                                }
                            }
                            .padding(.horizontal, Layout.scaleFactorW * 24)
                            .padding(.top, 16)
                            .padding(.bottom, 16)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .overlay(
                DetailsNavigationBarComponent()
            )
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct LocationDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailsScreen(
            store: Store(
                initialState: LocationDetailsState(location: Location()),
                reducer: locationDetailsReducer,
                environment: LocationDetailsEnvironment(
                    apiService: ServiceContainer().charactersService,
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            )
        )
    }
}
