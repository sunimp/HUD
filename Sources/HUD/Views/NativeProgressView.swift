//
//  NativeProgressView.swift
//  HUD
//
//  Created by Sun on 2021/11/30.
//

import UIKit

import SnapKit

class NativeProgressView: UIActivityIndicatorView, HUDAnimatedViewInterface {
    // MARK: Lifecycle

    init(activityIndicatorStyle: UIActivityIndicatorView.Style, color: UIColor? = nil) {
        super.init(frame: .zero)

        style = activityIndicatorStyle
        self.color = color

        commonInit()
    }

    @available(*, unavailable)
    required init(coder _: NSCoder) {
        fatalError("Can't use decoder")
    }

    // MARK: Overridden Functions

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

//        print("touch end")
    }

    // MARK: Functions

    func commonInit() {
        sizeToFit()
    }

    func set(valueChanger _: SmoothValueChanger?) {
        // can't set progress for native activity indicator
    }

    func set(progress _: Float) {
        // can't set progress for native activity indicator
    }
}
