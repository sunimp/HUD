//
//  DimHUDWindow.swift
//  HUD
//
//  Created by Sun on 2022/10/6.
//

import UIKit

// MARK: - DimHUDWindow

class DimHUDWindow: BackgroundHUDWindow {
    // MARK: Properties

    private var dimViewController: DimViewController?

    // MARK: Lifecycle

    init(
        windowScene: UIWindowScene,
        level: Level = UIWindow.Level.normal,
        config: HUDConfig = HUDConfig(),
        cornerRadius: CGFloat = 0
    ) {
        let coverView = DimCoverView(withModel: config)

        let dimViewController = DimViewController(coverView: coverView)
        self.dimViewController = dimViewController

        super.init(
            windowScene: windowScene,
            rootController: dimViewController,
            coverView: coverView,
            level: level,
            cornerRadius: cornerRadius
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DimHUDWindow {
    var onTap: (() -> Void)? {
        get { dimViewController?.onTap }
        set { dimViewController?.onTap = newValue }
    }
}
