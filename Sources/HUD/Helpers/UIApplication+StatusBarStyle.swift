//
//  UIApplication+StatusBarStyle.swift
//  CryptoWallet
//
//  Created by Sun on 2024/8/19.
//

import UIKit

extension UIApplication {
    
    /// Active window statusBar style
    public var activeStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
               let statusBarManager = windowScene.statusBarManager {
                return statusBarManager.statusBarStyle
            } else {
                return .default
            }
        } else {
            return UIApplication.shared.statusBarStyle
        }
    }
    
    /// Active window statusBar isHidden
    public var isActiveStatusBarHidden: Bool {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes
                .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
               let statusBarManager = windowScene.statusBarManager {
                return statusBarManager.isStatusBarHidden
            } else {
                return false
            }
        } else {
            return UIApplication.shared.isStatusBarHidden
        }
    }
}
