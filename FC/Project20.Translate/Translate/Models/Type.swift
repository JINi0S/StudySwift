//
//  Type.swift
//  Translate
//
//  Created by 이진희 on 2022/10/03.
//

import Foundation
import UIKit
enum `Type` {
    case source
    case target
    
    var color: UIColor{
        switch self {
        case .source: return .label
        case .target: return .mainTintColor
        }
    }
}
