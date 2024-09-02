//
//  HUDStatusView.swift
//
//  Created by Sun on 2021/11/30.
//

import UIKit

import SnapKit

public class HUDStatusView: UIView, HUDContentViewInterface, HUDTappableViewInterface {
    // MARK: Properties

    public var actions: [HUDTimeAction] = []

    private var imageView: UIView?
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    private var config: HUDStatusViewConfig

    // MARK: Computed Properties

    public var progressView: HUDAnimatedViewInterface? {
        imageView as? HUDAnimatedViewInterface
    }

    // MARK: Lifecycle

    public init(
        frame: CGRect,
        imageView: UIView?,
        titleLabel: UILabel?,
        subtitleLabel: UILabel?,
        config: HUDStatusViewConfig
    ) {
        self.imageView = imageView
        self.titleLabel = titleLabel
        self.subtitleLabel = subtitleLabel
        self.config = config

        super.init(frame: frame)

        commonInit()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
//        print("Deinit content \(self)")
    }

    // MARK: Functions

    public func isTappable() -> Bool {
        if let imageView = imageView as? HUDTappableViewInterface {
            return imageView.isTappable()
        }
        return true
    }

    private func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false

        if let subtitleLabel {
            addSubview(subtitleLabel)
            subtitleLabel.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().inset(HUDStatusViewTheme.textInsets.left)
                maker.trailing.equalToSuperview().inset(HUDStatusViewTheme.textInsets.right)
                maker.bottom.equalToSuperview().inset(HUDStatusViewTheme.textInsets.bottom)
            }
        }
        if let titleLabel {
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { maker in
                if imageView == nil {
                    maker.top.equalToSuperview().inset(config.imageInsets.top)
                }
                maker.leading.equalToSuperview().inset(config.textInsets.left)
                maker.trailing.equalToSuperview().inset(config.textInsets.right)
                if let subtitleLabel {
                    maker.bottom.equalTo(subtitleLabel.snp.top).offset(-config.titleBottomPadding)
                } else {
                    if imageView == nil {
                        maker.bottom.equalToSuperview().inset(config.textInsets.top)
                    } else {
                        maker.bottom.equalToSuperview().inset(config.textInsets.bottom)
                    }
                }
            }
        }
        if let imageView {
            addSubview(imageView)
            imageView.snp.makeConstraints { maker in
                maker.centerX.equalToSuperview()
                maker.leading.greaterThanOrEqualToSuperview().inset(config.imageInsets.left)
                maker.trailing.greaterThanOrEqualToSuperview().inset(config.imageInsets.right)
                maker.height.greaterThanOrEqualTo(imageView.frame.height)
                maker.width.greaterThanOrEqualTo(imageView.frame.width)
                if let bottomLabel = titleLabel ?? subtitleLabel {
                    maker.top.equalToSuperview().offset(config.imageTopPadding)
                    maker.bottom.equalTo(bottomLabel.snp.top).offset(-config.imageBottomPadding)
                } else {
                    maker.top.equalToSuperview().offset(config.imageInsets.top)
                    maker.bottom.equalToSuperview().inset(config.imageInsets.bottom)
                }
            }
        }
        layoutIfNeeded()
    }
}
