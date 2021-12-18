//
//  Created by Alexander Loshakov on 03.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct AppSegmentedControl: View {
    let store: Store<EpisodesState, EpisodesAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: Layout.scaleFactorW * 16) {
                    ForEach(viewStore.seasonsTitles.indices, id: \.self) { index in
                        Button(
                            action: {
                                viewStore.send(.seasonSelected(index))
                            },
                            label: {
                                Text(viewStore.seasonsTitles[index])
                                    .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                                    .foregroundColor(
                                        index == viewStore.selectedSeasonIndex
                                        ? Color.white
                                        : Color(Asset.Colors.grayDark.name)
                                    )
                                    .kerning(-0.32)
                            }
                        )
                        .padding(.vertical, Layout.scaleFactorW * 20)
                        .padding(.horizontal, Layout.scaleFactorW * 16)
                        .frame(height: Layout.scaleFactorW * 36)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .foregroundColor(Color(Asset.Colors.blackCard.name))
                        )
                    }
                    Spacer().frame(width: Layout.scaleFactorW * 8)
                }
            }
            .padding(.leading, Layout.scaleFactorW * 24)
        }
    }
}
