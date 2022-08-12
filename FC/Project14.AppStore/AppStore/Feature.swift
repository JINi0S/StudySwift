//
//  Feature.swift
//  AppStore
//
//  Created by 이진희 on 2022/08/12.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
    
}
