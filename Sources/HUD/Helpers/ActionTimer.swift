//
//  ActionTimer.swift
//
//  Created by Sun on 2021/11/30.
//

import Foundation

open class ActionTimer {
    // MARK: Properties

    var handler: (() -> Void)?

    // MARK: Static Functions

    public static func scheduledMainThreadTimer(
        action: (() -> Void)?,
        interval: TimeInterval,
        repeats: Bool = false,
        runLoopModes: RunLoop.Mode = RunLoop.Mode.common
    )
        -> Timer {
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

    // MARK: Functions

    @objc
    func timerEvent() {
        handler?()
    }
}
