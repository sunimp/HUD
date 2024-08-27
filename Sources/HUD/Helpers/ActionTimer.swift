//
//  HapticGenerator.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import Foundation

open class ActionTimer {

    var handler: (() -> Void)? = nil

    public static func scheduledMainThreadTimer(
        action: (() -> Void)?,
        interval: TimeInterval,
        repeats: Bool = false,
        runLoopModes: RunLoop.Mode = RunLoop.Mode.common
    ) -> Timer {
        let handledTimer = ActionTimer()
        handledTimer.handler = action

        let timer = Timer(
            fireAt: Date(timeIntervalSinceNow: interval),
            interval: interval,
            target: handledTimer,
            selector: #selector(timerEvent),
            userInfo: nil,
            repeats: repeats
        )
        RunLoop.main.add(timer, forMode: runLoopModes)

        return timer
    }

    @objc
    func timerEvent() {
        handler?()
    }
}
