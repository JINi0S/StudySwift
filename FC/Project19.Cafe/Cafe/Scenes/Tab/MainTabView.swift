//
//  MainTabView.swift
//  Cafe
//
//  Created by 이진희 on 2022/09/28.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Tab.home.imageItem
                    Tab.home.tabTextItem
                }
            OtherView()
                .tabItem {
                    Tab.other.imageItem
                    Tab.other.tabTextItem
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
