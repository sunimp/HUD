//
//  ViewController.swift
//  iOS Example
//
//  Created by Sun on 2024/8/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let presentButton = UIButton()
        view.addSubview(presentButton)
        
        presentButton.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(100)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(30)
        }
        
        presentButton.setTitleColor(.black, for: .normal)
        presentButton.setTitle("Present VC", for: .normal)
        presentButton.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
    }
    
    @objc 
    func presentVC() {
        let vc = PresentController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
