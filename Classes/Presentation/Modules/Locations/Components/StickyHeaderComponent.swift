//
//  Created by Nikita Gavrikov on 03.12.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct StickyHeaderComponent: View {
    let navigationImage: String
    let navigationTitle: String
    var isFilterHidden: Bool = false
    @Binding var searchRequest: String?
    @Binding var isFilterButtonActive: Bool
    let store: Store<EpisodesState, EpisodesAction>?

    var heightForHide: CGFloat {
        if store != nil {
            return Layout.scaleFactorH * 238
        }
        return Layout.scaleFactorH * 178
    }

    var heightForShow: CGFloat {
        if store != nil {
            return Layout.scaleFactorH * 400
        }
        return Layout.scaleFactorH * 324
    }

    var body: some View {
        GeometryReader { geo in
            let offset = geo.frame(in: .global).maxY
            ZStack {
                Color(Asset.Colors.blackBG.name)
                VStack(spacing: 0) {
                    ZStack {
                        if offset < heightForHide {
                            Color(Asset.Colors.blackBG.name)
                        } else {
                            NavigationImageComponent(image: navigationImage)
                        }
                        NavigationTitleComponent(title: navigationTitle)
                    }.onTapGesture {
                        dismissKeyboard()
                    }
                    if self.isFilterHidden {
                        SearchAndFilter(searchRequest: $searchRequest, isFilterButtonActive: $isFilterButtonActive)
                    } else {
                        VStack(spacing: 0) {
                            SearchBar(searchRequest: $searchRequest)
                                .frame(height: Layout.scaleFactorW * 52)
                                .padding(.horizontal, Layout.scaleFactorW * 24)
                                .padding(.top, Layout.scaleFactorH * 16)
                                .padding(.bottom, Layout.scaleFactorH * 8)
                            if let store = store {
                                AppSegmentedControl(store: store)
                                    .padding(.vertical, Layout.scaleFactorH * 16)
                            }
                        }
                    }
                }
            }
            .offset(y: geo.getOffsetForHeader)
        }
        .frame(height: heightForShow)
        .zIndex(1)
    }
}

// MARK: -  Get Offset For Sticky Header

extension GeometryProxy {

    var getOffsetForHeader: CGFloat {
        let offset = self.frame(in: .global).minY
        let sizeOffScreen: CGFloat = Layout.scaleFactorH * 154
        if offset < -sizeOffScreen {
            let headerOffset = abs(min(-sizeOffScreen, offset))
            return headerOffset - sizeOffScreen
        }
        if offset > 0 {
            return CGFloat(-offset)
        }
        return 0
    }
}
