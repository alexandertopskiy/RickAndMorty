//
//  Created by Nikita Gavrikov on 12.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI

struct EpisodeDetailsHeaderView: View {
    var episode: Episode

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(Asset.Colors.blackCard.name))
                    .frame(width: Layout.scaleFactorW * 148, height: Layout.scaleFactorW * 148)
                Image(uiImage: Asset.TabBarIcons.icEpisodesNotActive.image)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .foregroundColor(.white)
                    .frame(width: Layout.scaleFactorW * 48, height: Layout.scaleFactorW * 48)
            }
            Text(episode.name)
                .font(Font.appFontBold(ofSize: Layout.scaleFactorW * 22))
                .foregroundColor(.white)
                .frame(height: 25)
                .padding(.top, 24)
        }
    }
}
