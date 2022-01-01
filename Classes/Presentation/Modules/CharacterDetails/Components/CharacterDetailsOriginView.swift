//
//  Created by Nikita Gavrikov on 12.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct CharacterDetailsOriginView: View {
    var location: Location

    var body: some View {
        HStack {
            Text(L10n.Details.Character.origin)
                .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                .foregroundColor(.white)
                .frame(height: 22)
            Spacer()
        }
        .padding(.top, 24)
        .padding(.leading, Layout.scaleFactorW * 24)
        NavigationLink {
            LocationDetailsScreen(
                store: Store(
                    initialState: LocationDetailsState(location: location),
                    reducer: locationDetailsReducer,
                    environment: LocationDetailsEnvironment(
                        apiService: ServiceContainer().charactersService,
                        mainQueue: DispatchQueue.main.eraseToAnyScheduler()
                    )
                )
            )
        } label: {
            LocationsCardComponent(locationDetail: location)
        }
        .padding(.top, 16)
    }
}
