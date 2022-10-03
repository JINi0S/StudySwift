//
//  Event.swift
//  Cafe
//
//  Created by 이진희 on 2022/09/28.
//

import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    
    let image: Image
    let title: String //Text??
    let description: String
}
