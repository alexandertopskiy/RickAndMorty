//
//  Created by Александр Васильевич on 27.11.2021
//  Copyright © 2021 Ronas IT. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State private var isEditing: Bool = false
    @State private var isSearching: Bool = false

    var body: some View {
        HStack {
            TextField(
                "",
                text: $searchText,
                onEditingChanged: { startedEditing in
                    if startedEditing {
                        withAnimation {
                            if startedEditing {
                                isSearching = true
                                isEditing = true
                            }
                        }
                    }
                },
                onCommit: {
                    withAnimation {
                        if searchText.isEmpty {
                            isEditing = false
                            isSearching = false
                        } else {
                            print("searching: \(searchText)")
                        }
                    }
                }
            )
                .placeholder(when: searchText.isEmpty) {
                    HStack {
                        if !isSearching && !isEditing {
                            Image(Asset.Icons.icSearchSmall.name)
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color(Asset.Colors.grayDark.name))
                                .frame(width: Layout.scaleFactorW * 20, height: Layout.scaleFactorW * 20)
                        }
                        Text(L10n.Placeholder.search)
                            .font(Font.appFontMedium(ofSize: Layout.scaleFactorW * 16))
                            .kerning(-0.32)
                            .foregroundColor(Color(Asset.Colors.grayDark.name))
                            .frame(height: Layout.scaleFactorW * 20)
                            .scaledToFill()
                    }
                }
                .padding(.vertical, Layout.scaleFactorW * 16)
                .padding(.horizontal, Layout.scaleFactorW * 52)
                .background(Color(Asset.Colors.blackCard.name))
                .foregroundColor(Color(Asset.Colors.grayDark.name))
                .cornerRadius(16)
                .overlay(
                    HStack {
                        if isEditing {
                            Image(Asset.Icons.icSearchSmall.name)
                                .renderingMode(.template)
                                .foregroundColor(Color(Asset.Colors.grayDark.name))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, Layout.scaleFactorW * 16)
                            Button(
                                action: {
                                    withAnimation {
                                        self.searchText = ""
                                        self.isEditing = false
                                        self.isSearching = false
                                        UIApplication.shared.dismissKeyboard()
                                    }
                                },
                                label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(Color(Asset.Colors.grayDark.name))
                                        .padding(.trailing, Layout.scaleFactorW * 16)
                                }
                            )
                        }
                    }
                )
                .onTapGesture {
                    withAnimation {
                        self.isEditing = true
                    }
                }
        }
    }
}

// MARK: -  Custom Placeholder

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .center,
        @ViewBuilder placeholder: () -> Content) -> some View {
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
        }
}

// MARK: -  Dismiss Keyboard

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
