//
//  HapticGenerator.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import UIKit

// MARK: - HUDFeedbackGenerator

public protocol HUDFeedbackGenerator {
    func notification(_ notification: HapticNotificationType)
}

// MARK: - HapticGenerator

public class HapticGenerator: HUDFeedbackGenerator {
    
    public static let shared = HapticGenerator()
    
    let notificationGenerator = UINotificationFeedbackGenerator()
    var impactStyle: UIImpactFeedbackGenerator.FeedbackStyle = .light
    var impactGenerator = UIImpactFeedbackGenerator(style: .light)

    public func notification(_ notification: HapticNotificationType) {
        switch notification {
        case .error: notificationGenerator.notificationOccurred(.error)
        case .success: notificationGenerator.notificationOccurred(.success)
        case .warning: notificationGenerator.notificationOccurred(.warning)
        case .feedback(let style): if impactStyle != style {
                impactGenerator = UIImpactFeedbackGenerator(style: style)
            }
            impactGenerator.impactOccurred()
        }
    }

}
