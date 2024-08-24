//
//  HUDViewInteractor.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import Foundation

public enum HUDTimeActionType { 
    case show
    case dismiss
    case custom
}

public struct HUDTimeAction {
    var type: HUDTimeActionType
    var interval: TimeInterval
    var action: (() -> Void)?

    init(type: HUDTimeActionType, interval: TimeInterval, action: (() -> Void)? = nil) {
        self.type = type
        self.interval = interval
        self.action = action
    }

}

class HUDViewInteractor: HUDViewInteractorInterface {
    
    weak var delegate: HUDViewInteractorDelegate?

    deinit {
//        print("Deinit HUDView interactor \(self)")
    }

}
