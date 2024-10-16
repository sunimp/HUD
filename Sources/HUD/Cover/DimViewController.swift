//
//  DimViewController.swift
//  HUD
//
//  Created by Sun on 2022/10/6.
//

import UIKit

import SnapKit

// MARK: - DimViewController

class DimViewController: UIViewController {
    // MARK: Properties

    private var coverView: DimCoverView

    // MARK: Lifecycle

    init(coverView: DimCoverView) {
        self.coverView = coverView

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overridden Functions

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(coverView)

        coverView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}

extension DimViewController {
    var onTap: (() -> Void)? {
        get { coverView.onTapCover }
        set { coverView.onTapCover = newValue }
    }
}
