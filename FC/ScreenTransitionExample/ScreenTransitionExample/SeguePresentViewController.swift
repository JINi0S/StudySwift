//
//  SeguePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 이진희 on 2022/06/15.
//

import UIKit

class SeguePresentViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
