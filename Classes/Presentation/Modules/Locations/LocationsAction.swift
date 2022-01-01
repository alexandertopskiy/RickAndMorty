//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

enum LocationsAction: Equatable {
    case onAppear
    case fetchNextPage
    case locationCardSelected(Location)
    case dataLoaded(Result<GeneralRequest<Location>, NetworkError>)
    case searchInputChanged(String?)
    case filterButtonTapped
    case filter(FilterAction)
    case filterSettingsChanged
    case details(LocationDetailsAction)
}
