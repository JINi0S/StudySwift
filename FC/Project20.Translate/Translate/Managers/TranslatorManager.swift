//
//  TranslatorManager.swift
//  Translate
//
//  Created by 이진희 on 2022/10/03.
//

import Foundation
import Alamofire

struct TranslatorManager  {
    var sourceLanguage : Language = .ko
    var targetLanguage: Language = .en
    func translate(
        from text: String,
        completionHandler: @escaping(String) -> Void) {
        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt") else {return }
        
        let requestModel = TranslateRequestModel(
            source: sourceLanguage.languageCode,
            target: targetLanguage.languageCode,
            text: text)
    
    
        let headers : HTTPHeaders = [
            "X-Naver-Client-Id": "fZYZ0f7GkTUidwvuWAjL",
            "X-Naver-Client-Secret": "cBXWDp1oZ1"
        ]
        
        AF
            .request(url, method: .post, parameters: requestModel, headers: headers)
            .responseDecodable(of: TranslateResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result.translatedText)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    
}
