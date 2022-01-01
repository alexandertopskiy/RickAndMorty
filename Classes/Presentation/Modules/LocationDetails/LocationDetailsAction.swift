//
//  Created by Nikita Gavrikov on 12/12/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

enum LocationDetailsAction: Equatable {
    case onAppear
    case dataLoaded(Result<[Character], NetworkError>)
}
