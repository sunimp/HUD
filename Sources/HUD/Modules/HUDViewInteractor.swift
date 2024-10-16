//
//  HUDViewInteractor.swift
//  HUD
//
//  Created by Sun on 2021/11/30.
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
    // MARK: Properties

    var type: HUDTimeActionType
    var interval: TimeInterval
    var action: (() -> Void)?

    // MARK: Lifecycle

    init(type: HUDTimeActionType, interval: TimeInterval, action: (() -> Void)? = nil) {
        self.type = type
        self.interval = interval
        self.action = action
    }
}

// MARK: - HUDViewInteractor

class HUDViewInteractor: HUDViewInteractorInterface {
    // MARK: Properties

    weak var delegate: HUDViewInteractorDelegate?

    // MARK: Lifecycle

    deinit {
//        print("Deinit HUDView interactor \(self)")
    }
}
