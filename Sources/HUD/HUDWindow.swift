//
//  HUDWindow.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import SnapKit
import ThemeKit

class HUDWindow: ThemeWindow {
    
    override var frame: CGRect {
        didSet { // IMPORTANT. When window is square safeAreaInsets in willTransition controller rotate not changing!
            if abs(frame.height - frame.width) < 1 / UIScreen.main.scale {
                frame.size = CGSize(width: frame.width, height: frame.height + 1 / UIScreen.main.scale)
            }
        }
    }

    var transparent: Bool = false
    
    init(
        windowScene: UIWindowScene,
        rootController: UIViewController,
        level: UIWindow.Level = UIWindow.Level.normal,
        cornerRadius: CGFloat = 0
    ) {
        super.init(windowScene: windowScene)

        isHidden = false
        windowLevel = level
        backgroundColor = .clear
        rootViewController = rootController
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if transparent {
            return nil
        }

        return super.hitTest(point, with: event)
    }

}
