//
//  HUDModel.swift
//  HUD
//
//  Created by Sun on 2021/11/30.
//

import UIKit

// MARK: - HUDBannerStyle

public enum HUDBannerStyle: Int {
    case top
    case right
    case bottom
    case left
}

// MARK: - HUDSizeAppearStyle

public enum HUDSizeAppearStyle: Int {
    case horizontal
    case vertical
    case both
}

// MARK: - HUDStyle

public enum HUDStyle {
    case banner(HUDBannerStyle)
    case center
}

// MARK: - HUDAppearStyle

public enum HUDAppearStyle {
    case moveOut
    case alphaAppear
    case sizeAppear(HUDSizeAppearStyle)
}

// MARK: - HUDHandleKeyboardType

public enum HUDHandleKeyboardType {
    case startPosition
    case always
    case none
}

// MARK: - HapticNotificationType

public enum HapticNotificationType {
    case error
    case success
    case warning
    case feedback(UIImpactFeedbackGenerator.FeedbackStyle)
}

// MARK: - HUDCoverModel

public protocol HUDCoverModel {
    var coverInAnimationDuration: TimeInterval { get set }
    var coverOutAnimationDuration: TimeInterval { get set }
    var coverAnimationCurve: UIView.AnimationOptions { get set }
    var coverBackgroundColor: UIColor { get set }
    var coverBlurEffectStyle: UIBlurEffect.Style? { get set }
    var coverBlurEffectIntensity: CGFloat? { get set }

    var userInteractionEnabled: Bool { get set }
}

// MARK: - HUDContainerModel

public protocol HUDContainerModel {
    var startAdjustSize: CGFloat { get set }
    var finishAdjustSize: CGFloat { get set }

    var inAnimationDuration: TimeInterval { get set }
    var outAnimationDuration: TimeInterval { get set }
    var animationCurve: UIView.AnimationOptions { get set }

    var cornerRadius: CGFloat { get set }
    var blurEffectStyle: UIBlurEffect.Style? { get set }
    var blurEffectIntensity: CGFloat? { get set }
    var backgroundColor: UIColor { get set }

    var shadowRadius: CGFloat { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor { get set }
}

// MARK: - HUDViewModel

public protocol HUDViewModel {
    var userInteractionEnabled: Bool { get set }
    var handleKeyboard: HUDHandleKeyboardType { get set }

    var style: HUDStyle { get set }
    var appearStyle: HUDAppearStyle { get set }
    var hudInset: CGPoint { get set }
    var absoluteInsetsValue: Bool { get set }

    var finishAdjustSize: CGFloat { get set }
    var exactSize: Bool { get set }
    var preferredSize: CGSize { get set }
    var allowedMaximumSize: CGSize { get set } // maximum HUD size limitation in percent by screen size

    var inAnimationDuration: TimeInterval { get set }
    var animationCurve: UIView.AnimationOptions { get set }
}

// MARK: - HUDConfig

public struct HUDConfig: HUDViewModel, HUDCoverModel, HUDContainerModel {
    // MARK: Properties

    public var style: HUDStyle = .banner(.top)

    public var appearStyle: HUDAppearStyle = .alphaAppear
    public var startAdjustSize: CGFloat = HUDTheme.startAdjustSize
    public var finishAdjustSize: CGFloat = HUDTheme.finishAdjustSize

    public var exactSize: Bool = HUDTheme.exactSize
    public var preferredSize: CGSize = HUDTheme.preferredSize
    public var allowedMaximumSize: CGSize = HUDTheme
        .allowedSizeInPercentOfScreen // maximum HUD size limitation in percent by screen size
    public var hudInset = CGPoint(x: 0, y: -8)
    public var absoluteInsetsValue = false
    public var numberOfLines: Int = HUDTheme.numberOfLines

    public var coverInAnimationDuration: TimeInterval = HUDTheme.coverAppearDuration
    public var coverOutAnimationDuration: TimeInterval = HUDTheme.coverDisappearDuration
    public var coverAnimationCurve: UIView.AnimationOptions = HUDTheme.coverAnimationCurve
    public var coverBackgroundColor: UIColor = HUDTheme.coverBackgroundColor
    public var coverBlurEffectStyle: UIBlurEffect.Style? = nil
    public var coverBlurEffectIntensity: CGFloat? = HUDTheme.coverBlurEffectIntensity

    public var userInteractionEnabled = true
    public var handleKeyboard: HUDHandleKeyboardType = .startPosition

    public var inAnimationDuration: TimeInterval = HUDTheme.appearDuration
    public var outAnimationDuration: TimeInterval = HUDTheme.disappearDuration
    public var animationCurve: UIView.AnimationOptions = HUDTheme.animationCurve

    public var cornerRadius: CGFloat = HUDTheme.cornerRadius
    public var blurEffectStyle: UIBlurEffect.Style? = HUDTheme.blurEffectStyle
    public var blurEffectIntensity: CGFloat? = HUDTheme.blurEffectIntensity
    public var backgroundColor: UIColor = .clear // HUDTheme.backgroundColor

    public var shadowRadius: CGFloat = HUDTheme.shadowRadius
    public var borderWidth: CGFloat = HUDTheme.borderWidth
    public var borderColor: UIColor = .darkGray

    public var hapticType: HapticNotificationType? = .error

    // MARK: Lifecycle

    public init() { }
}
