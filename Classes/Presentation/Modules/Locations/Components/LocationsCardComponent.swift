//
//  Created by Nikita Gavrikov on 28.11.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI

struct LocationsCardComponent: View {
    let locationDetail: Location

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(Asset.Colors.blackCard.name))
                .frame(width: Layout.scaleFactorW * 327, height: 80, alignment: .center)
            HStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(Asset.Colors.blackElements.name))
                        .frame(width: Layout.scaleFactorW * 64, height: 64)
                    Image(uiImage: locationDetail.type.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: Layout.scaleFactorW * 24, height: 24)
                }
                .padding(.leading, Layout.scaleFactorW * 32)
                .padding(.trailing, Layout.scaleFactorW * 16)
                VStack(alignment: .leading, spacing: 0) {
                    Text(locationDetail.name)
                        .font(Font.appFontSemibold(ofSize: Layout.scaleFactorW * 17))
                        .frame(height: 22)
                        .foregroundColor(.white)
                        .padding(.bottom, 4)
                    Text(locationDetail.type.rawValue)
                        .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 13))
                        .frame(height: 18)
                        .foregroundColor(Color(Asset.Colors.primary.name))
                        .padding(.top, 4)
                }
                .padding(.trailing, Layout.scaleFactorW * 32)
                Spacer()
            }
        }
    }
}

struct LocationsCardComponent_Previews: PreviewProvider {
    static var previews: some View {
        LocationsCardComponent(locationDetail: Location())
    }
}
