//
//  StationArrivalDataResponseModel.swift
//  Subway
//
//  Created by 이진희 on 2022/08/13.
//

import Foundation

struct StationArrivalDatResponseModel: Decodable {
    var realtimeArrivalList: [RealTimeArrival] = []
    
    struct RealTimeArrival: Decodable {
        let line: String //~행
        let remainTime: String
        let currentStation: String
        
        enum CodingKeys: String, CodingKey {
            case line = "trainLineNm"
            case remainTime = "arvlMsg2"
            case currentStation = "arvlMsg3"
        }
    }
}
