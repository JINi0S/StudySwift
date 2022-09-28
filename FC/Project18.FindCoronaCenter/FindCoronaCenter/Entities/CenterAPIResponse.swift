//
//  CenterAPIResponse.swift
//  FindCoronaCenter
//
//  Created by 이진희 on 2022/09/27.
//

import Foundation

struct CenterAPIResponse: Decodable {
    let data: [Center]
}
