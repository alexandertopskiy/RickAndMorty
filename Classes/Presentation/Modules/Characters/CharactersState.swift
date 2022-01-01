//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

struct CharactersState: Equatable {
    let navigationImage: String = Asset.Illustrations.characters.name
    let navigationTitle: String = L10n.Characters.title
    var data: [Character] = []
    var isFilterButtonActive: Bool = false
    var isFilterPresented: Bool = false
    var filterParameters: FetchingParameters = FetchingParameters()
    var filter: FilterState = FilterState(filterType: .characters)
    var logInfo: NetworkError?
    var details = CharacterDetailsState(character: Character())
}
