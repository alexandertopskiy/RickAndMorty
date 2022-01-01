//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

enum EpisodesAction: Equatable {
    case onAppear
    case fetchNextPage
    case episodeCardSelected(Episode)
    case dataLoaded(Result<GeneralRequest<Episode>, NetworkError>)
    case searchInputChanged(String?)
    case seasonSelected(Int)
    case details(EpisodeDetailsAction)
}
