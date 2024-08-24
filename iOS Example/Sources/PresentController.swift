//
//  PresentController.swift
//  iOS Example
//
//  Created by Sun on 2024/8/23.
//

import UIKit

import HUD
import UIExtensions

class PresentController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let closeButton = UIButton()
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { maker in
            maker.height.equalTo(30)
            maker.width.equalTo(50)
            maker.leading.equalToSuperview().inset(20)
            maker.top.equalToSuperview().inset(100)
        }
        
        closeButton.setTitleColor(.zx017, for: .normal)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        
        let hudButton = UIButton()
        view.addSubview(hudButton)
        
        hudButton.snp.makeConstraints { maker in
            maker.top.equalToSuperview().offset(100)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(30)
        }
        
        hudButton.setTitleColor(.zx017, for: .normal)
        hudButton.setTitle("Show HUD", for: .normal)
        hudButton.addTarget(self, action: #selector(showHud), for: .touchUpInside)
    }
    
    @objc 
    func showHud() {
        show(title: "Hello World")
    }
    
    @objc 
    func close() {
        self.dismiss(animated: true)
    }
    
    private func show(title: String?) {
        var config = HUDConfig()
        config.style = .banner(.top)
        config.appearStyle = .moveOut
        config.userInteractionEnabled = true
        config.preferredSize = CGSize(width: 114, height: 56)
        
        config.coverBlurEffectStyle = nil
        config.coverBlurEffectIntensity = nil
        config.coverBackgroundColor = .zx013
        
        config.blurEffectStyle = .themeHud
        config.backgroundColor = .zx007
        config.blurEffectIntensity = 0.4
        
        config.cornerRadius = 28
        
        let viewItem = HUD.ViewItem(
            icon: UIImage(named: "copy_24"),
            iconColor: .cg001,
            title: "Copied",
            showingTime: 2,
            isLoading: false
        )
        
        HUD.shared.show(
            config: config,
            viewItem: viewItem,
            forced: true
        )
    }
    
}

