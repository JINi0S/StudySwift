//
//  MenuSuggestionSectionView.swift
//  Cafe
//
//  Created by 이진희 on 2022/09/28.
//

import SwiftUI

struct MenuSuggestionSectionView: View {
    @Binding var coffeeMenu: [CoffeeMenu]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                Text("\(User.shared.username)님을 위한 추천메뉴")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16.0)
                LazyHStack {
                    ForEach(coffeeMenu) { menu in
                        MenuSuggestionItemView(coffeeMenu: menu)
                    }
                }.padding(.horizontal, 16.0)

            }
        }
    }
}


struct MenuSuggestionItemView: View {
    let coffeeMenu: CoffeeMenu
    var body: some View {
        VStack {
            coffeeMenu.image
                .resizable()
                .clipShape(Circle())
                .frame(width: 100.0, height: 100.0)
            Text(coffeeMenu.name)
                .font(.caption)
        }
    }
}
