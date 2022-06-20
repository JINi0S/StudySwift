//
//  RoundButton.swift
//  Project04.Calculator
//
//  Created by 이진희 on 2022/06/20.
//

import UIKit


@IBDesignable
class RoundButton: UIButton {

    @IBInspectable var isRound: Bool = false{
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
