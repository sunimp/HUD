//
//  HUDCoverView.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import UIKit

// MARK: - HUDCoverView

open class HUDCoverView: UIView, CoverViewInterface {
    public weak var delegate: CoverViewDelegate?
    public var transparent = false
    public var coverBackgroundColor: UIColor? = nil

    public var onTapCover: (() -> Void)? = nil
    public var isVisible: Bool { !isHidden }

    public func show(animated _: Bool) { }

    public func hide(animated _: Bool, completion _: (() -> Void)?) { }
}

// MARK: - CoverViewInterface

public protocol CoverViewInterface {
    var delegate: CoverViewDelegate? { get set }
    var transparent: Bool { get set }

    var onTapCover: (() -> Void)? { get set }
    var coverBackgroundColor: UIColor? { get set }
    var isVisible: Bool { get }
    var appearDuration: TimeInterval { get }
    var disappearDuration: TimeInterval { get }
    var animationCurve: UIView.AnimationOptions { get }

    func show(animated: Bool)
    func hide(animated: Bool, completion: (() -> Void)?)
}

extension CoverViewInterface {
    public var appearDuration: TimeInterval {
        HUDTheme.coverAppearDuration
    }

    public var disappearDuration: TimeInterval {
        HUDTheme.coverDisappearDuration
    }

    public var animationCurve: UIView.AnimationOptions {
        HUDTheme.coverAnimationCurve
    }
}

// MARK: - CoverViewDelegate

public protocol CoverViewDelegate: AnyObject {

    func willShow()
    func didShow()

    func willHide()
    func didHide()
}

extension CoverViewDelegate {
    func willShow() { }

    func didShow() { }

    func willHide() { }

    func didHide() { }
}
