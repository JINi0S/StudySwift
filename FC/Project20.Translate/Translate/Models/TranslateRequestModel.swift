//
//  TranslateRequestModel.swift
//  Translate
//
//  Created by 이진희 on 2022/10/03.
//

import Foundation

struct TranslateRequestModel: Codable {
    let source: String
    let target: String
    let text: String
}
