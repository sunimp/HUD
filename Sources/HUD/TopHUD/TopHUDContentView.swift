//
//  TopHUDContentView.swift
//  HUD
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

    private let stackView = UIStackView()
    private let loadingView = HUDProgressView(progress: nil, strokeLineWidth: 2, radius: 16, strokeColor: .zx002)
    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    private var loading = false

    // MARK: Lifecycle

    init() {
        super.init(frame: .zero)
        
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.spacing = CGFloat.margin12 - 1
        stackView.alignment = .center
        stackView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(19)
            maker.trailing.equalToSuperview().inset(32)
            maker.top.bottom.equalToSuperview().inset(CGFloat.margin12 - 1)
        }

        stackView.addArrangedSubview(loadingView)
        loadingView.snp.makeConstraints { maker in
            maker.size.equalTo(34)
        }

        loadingView.isHidden = true

        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)

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
    
    var numberOfLines: Int {
        get { titleLabel.numberOfLines }
        set { titleLabel.numberOfLines = newValue }
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
