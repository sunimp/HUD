//
//  DimCoverView.swift
//  HUD
//
//  Created by Sun on 2021/11/30.
//

import UIKit

open class DimCoverView: HUDCoverView {
    // MARK: Overridden Properties

    override public var isVisible: Bool {
        !isHidden
    }

    override public var coverBackgroundColor: UIColor? {
        get {
            dimBackgroundView.backgroundColor
        }
        set {
            dimBackgroundView.backgroundColor = newValue
        }
    }

    // MARK: Properties

    private let model: HUDCoverModel

    private let dimBackgroundView: UIView

    // MARK: Lifecycle

    public init(withModel model: HUDCoverModel, backgroundView: UIView? = nil) {
        self.model = model
        dimBackgroundView = backgroundView ?? UIView()
        super.init(frame: .zero)

        commonInit()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
//        print("Deinit coverView \(self)")
    }

    // MARK: Overridden Functions

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onTapCover?()

        super.touchesEnded(touches, with: event)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        dimBackgroundView.frame = bounds
    }

    override public func show(animated: Bool) {
        delegate?.willShow()
        isHidden = false
        if animated {
            UIView.animate(
                withDuration: model.coverInAnimationDuration,
                delay: 0,
                options: model.coverAnimationCurve,
                animations: {
                    self.dimBackgroundView.alpha = 1
                },
                completion: { [weak self] _ in
                    self?.delegate?.didShow()
                }
            )
        } else {
            dimBackgroundView.alpha = 1
            delegate?.didShow()
        }
    }

    override public func hide(animated: Bool, completion: (() -> Void)?) {
        delegate?.willHide()
        if animated {
            UIView.animate(
                withDuration: model.coverOutAnimationDuration,
                delay: 0,
                options: model.coverAnimationCurve,
                animations: {
                    self.dimBackgroundView.alpha = 0
                },
                completion: { [weak self] _ in
                    self?.isHidden = true

                    self?.delegate?.didHide()
                    completion?()
                }
            )
        } else {
            dimBackgroundView.alpha = 0
            isHidden = true

            delegate?.didHide()
            completion?()
        }
    }

    // MARK: Functions

    func commonInit() {
        isHidden = true

        dimBackgroundView.backgroundColor = model.coverBackgroundColor
        dimBackgroundView.alpha = 0

        addSubview(dimBackgroundView)
    }
}
