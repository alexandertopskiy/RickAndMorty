//
//  Created by Nikita Gavrikov on 12/12/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct EpisodeDetailsScreen: View {
    let store: Store<EpisodeDetailsState, EpisodeDetailsAction>
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                Color(Asset.Colors.blackBG.name)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .center, spacing: 0) {
                        EpisodeDetailsHeaderView(episode: viewStore.episode)
                            .padding(.top, Layout.scaleFactorH * 108)
                        EpisodeDetailsInfoView(episode: viewStore.episode)
                            .padding(.top, 24)
                        if !viewStore.episode.characters.isEmpty {
                            HStack {
                                Text(L10n.Details.Episode.scrollTitle)
                                    .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                                    .foregroundColor(.white)
                                    .frame(height: 22)
                                Spacer()
                            }
                            .padding(.top, 24)
                            .padding(.leading, Layout.scaleFactorW * 24)
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewStore.episode.characters, id: \.id) { character in
                                    NavigationLink {
                                        CharacterDetailsScreen(
                                            store: Store(
                                                initialState: CharacterDetailsState(character: character),
                                                reducer: characterDetailsReducer,
                                                environment: CharacterDetailsEnvironment(
                                                    apiService: ServiceContainer().episodesService,
                                                    apiServiceLocation: ServiceContainer().locationsService,
                                                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                                                )
                                            )
                                        )
                                    } label: {
                                        CharacterCard(сharacter: character)
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

struct EpisodeDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsScreen(
            store: Store(
                initialState: EpisodeDetailsState(episode: Episode()),
                reducer: episodeDetailsReducer,
                environment: EpisodeDetailsEnvironment(
                    apiService: ServiceContainer().charactersService,
                    mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                )
            )
        )
    }
}
