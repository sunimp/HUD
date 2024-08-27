//
//  HUDStatusFactory.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import UIKit

// MARK: - HUDProgressType

public enum HUDProgressType {
    case native
    case custom
}

// MARK: - HUDStatusType

public enum HUDStatusType {
    case custom(UIImage)
    case progress(HUDProgressType)
    case success
    case info
    case error
}

// MARK: - HUDStatusFactory

public class HUDStatusFactory {
    
    public static let shared = HUDStatusFactory()

    public var config = HUDStatusModel()

    init() { }

    public func view(
        type: HUDStatusType,
        title: String? = nil,
        subtitle: String? = nil
    ) -> HUDStatusView {
        var image: UIImage?
        let imageView: UIView
        var imageViewActions = [HUDTimeAction]()

        var progressType: HUDProgressType?
        switch type {
        case .info: image = config.infoImage
        case .error: image = config.errorImage
        case .success: image = config.successImage
        case .progress(let type): progressType = type
        case .custom(let customImage): image = customImage
        }
        if let progressType {
            let animatedImageView: UIView & HUDAnimatedViewInterface
            switch progressType {
            case .native: animatedImageView = NativeProgressView(
                    activityIndicatorStyle: config.activityIndicatorStyle,
                    color: config.activityIndicatorColor
                )

            case .custom:
                let progressView = HUDProgressView(
                    progress: config.customProgressValue,
                    strokeLineWidth: config.customProgressLineWidth,
                    radius: config.customProgressRadius,
                    strokeColor: config.customProgressColor,
                    donutColor: config.customDonutColor,
                    duration: config.customProgressDuration
                )
                if let interval = config.customShowCancelInterval {
                    imageViewActions.append(HUDTimeAction(
                        type: .custom,
                        interval: interval,
                        action: { [weak self, weak progressView] in
                            progressView?.appendInCenter(image: self?.config.cancelImage)
                            HapticGenerator.shared.notification(.feedback(.medium))
                        }
                    ))
                }
                animatedImageView = progressView
            }
            imageViewActions.append(HUDTimeAction(type: .custom, interval: 0, action: {
                animatedImageView.startAnimating()
            }))
            imageView = animatedImageView
        } else {
            let tintedImage = image?.withRenderingMode(config.imageTintColor != nil ? .alwaysTemplate : .alwaysOriginal)

            imageView = UIImageView(image: tintedImage)
            imageView.tintColor = config.imageTintColor
            imageView.contentMode = config.imageContentMode
        }

        var titleLabel: UILabel?
        if let title {
            titleLabel = UILabel()
            titleLabel?.font = config.titleLabelFont
            titleLabel?.textColor = config.titleLabelColor
            titleLabel?.numberOfLines = config.titleLabelLinesCount
            titleLabel?.textAlignment = config.titleLabelAlignment
            titleLabel?.text = title
        }

        var subtitleLabel: UILabel?
        if let subtitle {
            subtitleLabel = UILabel()
            subtitleLabel?.font = config.subtitleLabelFont
            subtitleLabel?.textColor = config.subtitleLabelColor
            subtitleLabel?.numberOfLines = config.subtitleLabelLinesCount
            subtitleLabel?.textAlignment = config.subtitleLabelAlignment
            subtitleLabel?.text = subtitle
        }

        let hudStatusView = HUDStatusView(
            frame: .zero,
            imageView: imageView,
            titleLabel: titleLabel,
            subtitleLabel: subtitleLabel,
            config: config
        )

        hudStatusView.actions.append(contentsOf: imageViewActions)
        if let showTimeInterval = config.showTimeInterval {
            hudStatusView.actions.append(HUDTimeAction(type: .show, interval: showTimeInterval, action: nil))
        }
        if let dismissTimeInterval = config.dismissTimeInterval {
            hudStatusView.actions.append(HUDTimeAction(type: .dismiss, interval: dismissTimeInterval, action: nil))
        }
        return hudStatusView
    }

}
