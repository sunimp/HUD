//
//  SceneDelegate.swift
//  iOS Example
//
//  Created by Sun on 2024/8/24.
//

import UIKit

import ThemeKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    // MARK: Scene Lifecycle
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        Theme.updateNavigationBarTheme()
        window = ThemeWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .zx009
        window?.rootViewController = ViewController()
    }
}
