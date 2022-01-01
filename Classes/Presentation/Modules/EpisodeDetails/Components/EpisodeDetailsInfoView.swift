//
//  Created by Nikita Gavrikov on 12.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI

struct EpisodeDetailsInfoView: View {
    var episode: Episode

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(L10n.Details.Info.title)
                    .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                    .foregroundColor(.white)
                    .frame(height: 22)
                Spacer()
            }
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color(Asset.Colors.blackCard.name))
                    .frame(width: Layout.scaleFactorW * 327, height: 136)
                VStack(spacing: 16) {
                    HStack {
                        Text(L10n.Details.Info.episode)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .foregroundColor(Color(Asset.Colors.grayNormal.name))
                            .frame(height: 24)
                        Spacer()
                        Text(episodeCodeReadable.episode)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .foregroundColor(.white)
                            .frame(height: 24)
                    }
                    HStack {
                        Text(L10n.Details.Info.season)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .foregroundColor(Color(Asset.Colors.grayNormal.name))
                            .frame(height: 24)
                        Spacer()
                        Text(episodeCodeReadable.season)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .foregroundColor(.white)
                            .frame(height: 24)
                    }
                    HStack {
                        Text(L10n.Details.Info.airDate)
                            .font(Font.appFontMedium(ofSize: 16))
                            .foregroundColor(Color(Asset.Colors.grayNormal.name))
                            .frame(height: 24)
                        Spacer()
                        Text(episode.date)
                            .font(Font.appFontMedium(ofSize: 16))
                            .foregroundColor(.white)
                            .frame(height: 24)
                    }
                }
                .padding(.horizontal, Layout.scaleFactorW * 16)
                .padding(.vertical, 16)
            }
        }
        .padding(.horizontal, Layout.scaleFactorW * 24)
    }
}

// MARK: -  Get value for EpisodeDetailsInfoView

extension EpisodeDetailsInfoView {

    var episodeCodeReadable: (episode: String, season: String) {
        guard let episodeNumber = episode.convertedEpisodeCode?.episodeNumber,
              let seasonNumber = episode.convertedEpisodeCode?.seasonNumber else {
                  return (L10n.Episodes.SeasonCode.unknown, L10n.Episodes.SeasonCode.unknown)
              }
        return ("\(episodeNumber)", "\(seasonNumber)")
    }
}
