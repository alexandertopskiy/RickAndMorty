//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct EpisodesScrollView: View {
    let store: Store<EpisodesState, EpisodesAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            LazyVStack(spacing : Layout.scaleFactorW * 16) {
                ForEach(viewStore.seasonsSet.sorted(), id: \.self) { seasonTitleNumber in
                    HStack {
                        Text("\(L10n.Episodes.SeasonCode.season) \(seasonTitleNumber)")
                            .foregroundColor(.white)
                            .font(Font.appFontBold(ofSize: Layout.scaleFactorW * 20))
                            .kerning(0.38)
                        Spacer()
                    }
                    ForEach(viewStore.data, id: \.id) { episode in
                        if let (_, seasonNumber) = episode.convertedEpisodeCode {
                            if seasonTitleNumber == seasonNumber {
                                HStack(spacing: Layout.scaleFactorW * 16) {
                                    NavigationLink(destination: DetailsHelloComponent()) {
                                        EpisodeCard(episode: episode)
                                    }
                                }
                            }
                        }
                    }
                }
                if viewStore.filterParameters.page < viewStore.filterParameters.totalPages {
                    AnimationViewComponent()
                        .frame(width: Layout.scaleFactorW * 50, height: Layout.scaleFactorW * 50)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                viewStore.send(.fetchNextPage)
                            }
                        }
                }
            }
            .padding(.horizontal, Layout.scaleFactorW * 23)
        }
    }
}
