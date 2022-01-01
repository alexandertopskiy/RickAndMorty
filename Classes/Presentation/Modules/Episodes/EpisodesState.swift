//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

struct EpisodesState: Equatable {
    let navigationImage: String = Asset.Illustrations.episodes.name
    let navigationTitle: String = L10n.Episodes.title
    let seasonsNumberArray: [Int] = [1, 2, 3, 4, 5]
    var data: [Episode] = []
    var filterParameters: FetchingParameters = FetchingParameters()
    var seasonsSet = Set<Int>()
    var selectedSeasonIndex: Int = 0
    var seasonsTitles: [String] = []
    var logInfo: NetworkError?
    var details: EpisodeDetailsState = EpisodeDetailsState(episode: Episode())
}
