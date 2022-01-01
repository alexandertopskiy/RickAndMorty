//
//  Created by Nikita Gavrikov on 12/12/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct CharacterDetailsScreen: View {
    let store: Store<CharacterDetailsState, CharacterDetailsAction>
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                Color(Asset.Colors.blackBG.name)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 0) {
                        CharacterDetailsHeaderView(character: viewStore.character)
                            .padding(.top, Layout.scaleFactorH * 108)
                        CharacterDetailsInfoView(character: viewStore.character)
                            .padding(.top, 24)
                        if !viewStore.character.originLocation.isEmpty {
                            CharacterDetailsOriginView(location: viewStore.character.originLocation[0])
                        }
                        if !viewStore.character.episodes.isEmpty {
                            HStack {
                                Text(L10n.Details.Character.scrollTitle)
                                    .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                                    .foregroundColor(.white)
                                    .frame(height: 22)
                                Spacer()
                            }
                            .padding(.top, 24)
                            .padding(.leading, Layout.scaleFactorW * 24)
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewStore.character.episodes, id: \.id) { episode in
                                    NavigationLink {
                                        EpisodeDetailsScreen(
                                            store: Store(
                                                initialState: EpisodeDetailsState(episode: episode),
                                                reducer: episodeDetailsReducer,
                                                environment: EpisodeDetailsEnvironment(
                                                    apiService: ServiceContainer().charactersService,
                                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                                )
                                            )
                                        )
                                    } label: {
                                        EpisodeCard(episode: episode)
                                    }
                                }
                                .padding(.horizontal, Layout.scaleFactorW * 24)
                            }
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
                viewStore.send(.onAppearOrigin)
            }
        }
    }
}

struct CharacterDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsScreen(
            store: Store(
                initialState: CharacterDetailsState(character: Character()),
                reducer: characterDetailsReducer,
                environment: CharacterDetailsEnvironment(
                    apiService: ServiceContainer().episodesService,
                    apiServiceLocation: ServiceContainer().locationsService,
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            )
        )
    }
}
