//
//  ViewController.swift
//  ScreenTransitionExample
//
//  Created by 이진희 on 2022/06/14.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewController 뷰가 로드되었다.")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewController 뷰가 나타날 것이다.")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewController 뷰가 나타났다.")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewController 뷰가 사라질것이다.")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewController 뷰가 사라졌다 .")
    }
    
    @IBAction func tapCodePushButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePushViewController") as? CodePushViewController else { return }
        viewController.name = "Gunder"
        self.navigationController?.pushViewController(viewController, animated: true)
       
    }
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CodePresentViewController") as? CodePresentViewController else { return }
        viewController.modalPresentationStyle = .fullScreen //풀스크린 방법
        viewController.name = "Gunter"
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SeguePushViewController{
            viewController.name = "Gunter"
        }
    }//이렇게 프리페어 메서드를 오버라이드 시켜주면 세그웨이를 실행하기 직전에 시스템에 의해서 오버라이드 된 프리페어 메서드가 자동으로 호출되게 됩니다/ 프리페어 메서드 안에 전환하려는 인스턴스를 가져와보자.
    
    func sendData(name: String){
        self.nameLabel.text = name
        self.nameLabel.sizeToFit()
        
    }
    
}
