//
//  DimHUDWindow.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import UIKit

class DimHUDWindow: BackgroundHUDWindow {
    private var dimViewController: DimViewController?

    init(frame: CGRect, level: Level = UIWindow.Level.normal, config: HUDConfig = HUDConfig(), cornerRadius: CGFloat = 0) {
        let coverView = DimCoverView(withModel: config)

        let dimViewController = DimViewController(coverView: coverView)
        self.dimViewController = dimViewController

        super.init(frame: frame, rootController: dimViewController, coverView: coverView, level: level, cornerRadius: cornerRadius)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension DimHUDWindow {

    var onTap: (() -> ())? {
        get { dimViewController?.onTap }
        set { dimViewController?.onTap = newValue }
    }

}
