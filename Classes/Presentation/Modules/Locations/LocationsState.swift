//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

struct LocationsState: Equatable {
    let navigationImage: String = Asset.Illustrations.locations.name
    let navigationTitle: String = L10n.Locations.title
    var data: [Location] = []
    var isFilterButtonActive: Bool = false
    var isFilterPresented: Bool = false
    var filterParameters: FetchingParameters = FetchingParameters()
    var filter: FilterState = FilterState(filterType: .locations)
    var logInfo: NetworkError?
    var details = LocationDetailsState(location: Location())
}
