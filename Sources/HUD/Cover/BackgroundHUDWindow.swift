//
//  BackgroundHUDWindow.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import UIKit

class BackgroundHUDWindow: HUDWindow {
    
    private(set) var coverView: CoverViewInterface

    init(
        windowScene: UIWindowScene,
        rootController: UIViewController,
        coverView: CoverViewInterface,
        level: UIWindow.Level = UIWindow.Level.normal,
        cornerRadius: CGFloat = 0
    ) {
        self.coverView = coverView
        super.init(
            windowScene: windowScene,
            rootController: rootController,
            level: level,
            cornerRadius: cornerRadius
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(transparent: Bool) {
        self.transparent = transparent
        coverView.transparent = transparent
    }
}
