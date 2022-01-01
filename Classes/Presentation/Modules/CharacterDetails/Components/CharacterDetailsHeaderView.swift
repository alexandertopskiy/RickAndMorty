//
//  Created by Nikita Gavrikov on 12.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI

struct CharacterDetailsHeaderView: View {
    var character: Character

    var body: some View {
        VStack(spacing: 0) {
            AppImageView(url: URL(string: character.image))
                .cornerRadius(16)
                .frame(width: Layout.scaleFactorW * 148, height: Layout.scaleFactorW * 148)
            Text(character.name)
                .font(Font.appFontBold(ofSize: Layout.scaleFactorW * 22))
                .foregroundColor(.white)
                .frame(height: 25)
                .padding(.top, 24)
            Text(character.status.rawValue)
                .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                .foregroundColor(Color(Asset.Colors.primary.name))
                .frame(height: 20)
                .padding(.top, 8)
        }
    }
}
