//
//  HapticGenerator.swift
//  HUD
//
//  Created by Sun on 2021/11/30.
//

import UIKit

// MARK: - HUDFeedbackGenerator

public protocol HUDFeedbackGenerator {
    func notification(_ notification: HapticNotificationType)
}

// MARK: - HapticGenerator

public class HapticGenerator: HUDFeedbackGenerator {
    // MARK: Static Properties

    public static let shared = HapticGenerator()

    // MARK: Properties

    let notificationGenerator = UINotificationFeedbackGenerator()
    var impactStyle: UIImpactFeedbackGenerator.FeedbackStyle = .light
    var impactGenerator = UIImpactFeedbackGenerator(style: .light)

    // MARK: Functions

    public func notification(_ notification: HapticNotificationType) {
        switch notification {
        case .error: notificationGenerator.notificationOccurred(.error)
        case .success: notificationGenerator.notificationOccurred(.success)
        case .warning: notificationGenerator.notificationOccurred(.warning)
        case let .feedback(style): if impactStyle != style {
                impactGenerator = UIImpactFeedbackGenerator(style: style)
            }
            impactGenerator.impactOccurred()
        }
    }
}
