//
//  RankingFeature.swift
//  AppStore
//
//  Created by 이진희 on 2022/08/12.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
