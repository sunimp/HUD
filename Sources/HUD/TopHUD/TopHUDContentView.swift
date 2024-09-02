//
//  TopHUDContentView.swift
//
//  Created by Sun on 2022/10/6.
//

import UIKit

import SnapKit
import ThemeKit
import UIExtensions

// MARK: - TopHUDContentView

class TopHUDContentView: UIView {
    // MARK: Properties

    public var actions: [HUDTimeAction] = []

    private let loadingView = HUDProgressView(progress: nil, strokeLineWidth: 2, radius: 16, strokeColor: .zx002)
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    private var loading = false

    // MARK: Lifecycle

    init() {
        super.init(frame: .zero)

        addSubview(loadingView)
        loadingView.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(CGFloat.margin12 - 1)
            maker.leading.equalToSuperview().inset(19)
            maker.size.equalTo(34)
        }

        loadingView.isHidden = true

        addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.center.equalTo(loadingView)
        }

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(loadingView.snp.trailing).offset(CGFloat.margin12 - 1)
            maker.centerY.equalTo(loadingView)
            maker.trailing.equalToSuperview().inset(32)
        }

        titleLabel.font = .subhead1
        titleLabel.textColor = .zx002
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopHUDContentView {
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }

    var icon: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }

    var iconColor: UIColor {
        get { imageView.tintColor }
        set { imageView.tintColor = newValue }
    }

    var isLoading: Bool {
        get { loading }
        set {
            if newValue != loading {
                loadingView.isHidden = !newValue

                if newValue {
                    loadingView.startAnimating()
                } else {
                    loadingView.stopAnimating()
                }

                loading = newValue
            }
        }
    }
}

// MARK: HUDContentViewInterface, HUDTappableViewInterface

extension TopHUDContentView: HUDContentViewInterface, HUDTappableViewInterface {
    public func isTappable() -> Bool { true }
}
