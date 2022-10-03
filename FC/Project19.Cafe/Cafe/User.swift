//
//  User.swift
//  Cafe
//
//  Created by 이진희 on 2022/09/29.
//

import Foundation

struct User {
    let username: String
    let account: String
    
    static let shared = User(username: "wlsgml", account: "jinhee.campus")
}
