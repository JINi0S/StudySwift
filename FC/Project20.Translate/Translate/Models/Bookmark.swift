//
//  Bookmark.swift
//  Translate
//
//  Created by 이진희 on 2022/10/03.
//

import Foundation

struct Bookmark: Codable {
    let sourceLanguage: Language
    let translatedLanguage: Language
    
    let sourceText: String
    let translatedText: String
}
