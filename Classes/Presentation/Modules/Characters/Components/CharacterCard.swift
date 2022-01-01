//
//  Created by Alexander Loshakov on 27.11.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI

struct CharacterCard: View {
    let сharacter: Character

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .frame(
                    width: Layout.scaleFactorW * 156,
                    height: Layout.scaleFactorW * 202
                )
                .foregroundColor(Color(Asset.Colors.blackCard.name))
            VStack(spacing: 0) {
                AppImageView(url: URL(string: сharacter.image))
                    .cornerRadius(10)
                    .frame(
                        width: Layout.scaleFactorW * 140,
                        height: Layout.scaleFactorW * 140
                    )
                    .padding(.top, Layout.scaleFactorW * 8)
                Spacer()
                    .frame(height: 16)
                Text(сharacter.name)
                    .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                    .foregroundColor(.white)
                    .kerning(-0.41)
                    .padding(.vertical, Layout.scaleFactorW * 16)
                    .frame(
                        width: Layout.scaleFactorW * 140,
                        height: Layout.scaleFactorW * 22
                    )
                Spacer()
                    .frame(height: 16)
            }
        }
    }
}

struct CharacterCard_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCard(сharacter: Character())
    }
}
