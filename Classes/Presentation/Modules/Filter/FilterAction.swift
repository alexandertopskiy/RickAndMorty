//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

enum FilterAction: Equatable {
    case onAppear
    case countOfSelectedChanged(Int)
    case indicesOfCharactersChanged([Int?])
    case indicesOfLocationsChanged([Int?])
    case filterParametersChanged(FetchingParameters)
    case applyFilter
    case onDisappear
}
