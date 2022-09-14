//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 이진희 on 2022/09/06.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
