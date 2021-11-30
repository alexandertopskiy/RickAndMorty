//
//  Created by Alexander Loshakov on 18/11/2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct SplashScreen: View {
    let store: Store<SplashState, SplashAction>

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                TabBarScreen(
                    store: .init(
                        initialState: TabBarState(),
                        reducer: tabBarReducer,
                        environment: TabBarEnvironment()
                    )
                )
                ZStack {
                    Color(Asset.Colors.blackBG.color)
                        .edgesIgnoringSafeArea(.all)
                    Image(Asset.Illustrations.SplashIllustrations.splashStars.name)
                        .resizable()
                        .padding(.leading, Layout.scaleFactorW * 16.0)
                        .padding(.trailing, Layout.scaleFactorW * 25.0)
                        .padding(.top, Layout.scaleFactorH * 98.0)
                        .padding(.bottom, Layout.scaleFactorH * 64.0)
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 0) {
                        Image(Asset.Illustrations.SplashIllustrations.splashTitle.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Layout.scaleFactorW * 140, height: Layout.scaleFactorH * 40, alignment: .center)
                            .padding(.top, Layout.scaleFactorH * 164.0)
                            .edgesIgnoringSafeArea(.all)
                        Spacer()
                            .frame(height: Layout.scaleFactorH * 36)
                        Image(Asset.Illustrations.SplashIllustrations.splashPortal.name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: Layout.scaleFactorW * 140, height: Layout.scaleFactorH * 228, alignment: .center)
                            .edgesIgnoringSafeArea(.all)
                        Spacer()
                            .frame(height: Layout.scaleFactorH * 133)
                        AnimationViewComponent(isPlaying: true)
                            .frame(width: Layout.scaleFactorW * 72, height: Layout.scaleFactorH * 72)
                            .padding(.bottom, Layout.scaleFactorH * 180)
                    }
                }
                .edgesIgnoringSafeArea([.top, .horizontal])
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(
            store: Store(
                initialState: SplashState(),
                reducer: splashReducer,
                environment: SplashEnvironment()
            )
        )
    }
}
