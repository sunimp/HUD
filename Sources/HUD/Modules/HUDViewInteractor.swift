//
//  HUDViewInteractor.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import Foundation

// MARK: - HUDTimeActionType

public enum HUDTimeActionType {
    case show
    case dismiss
    case custom
}

// MARK: - HUDTimeAction

public struct HUDTimeAction {
    var type: HUDTimeActionType
    var interval: TimeInterval
    var action: (() -> Void)? = nil

    init(type: HUDTimeActionType, interval: TimeInterval, action: (() -> Void)? = nil) {
        self.type = type
        self.interval = interval
        self.action = action
    }

}

// MARK: - HUDViewInteractor

class HUDViewInteractor: HUDViewInteractorInterface {
    
    weak var delegate: HUDViewInteractorDelegate?

    deinit {
//        print("Deinit HUDView interactor \(self)")
    }

}
