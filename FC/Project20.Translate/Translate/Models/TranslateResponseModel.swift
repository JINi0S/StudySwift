//
//  TranslateResponseModel.swift
//  Translate
//
//  Created by 이진희 on 2022/10/03.
//

import Foundation

struct TranslateResponseModel: Decodable {
    private let message: Message
    
    var translatedText: String { message.result.translatedText
    }

    struct Message: Decodable {
        let result: Result
    }
    
    struct Result: Decodable {
        let translatedText: String

    }
}
