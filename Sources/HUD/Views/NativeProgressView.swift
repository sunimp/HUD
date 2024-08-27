//
//  NativeProgressView.swift
//  HUD
//
//  Created by Sun on 2024/8/19.
//

import UIKit

import SnapKit

class NativeProgressView: UIActivityIndicatorView, HUDAnimatedViewInterface {

    init(activityIndicatorStyle: UIActivityIndicatorView.Style, color: UIColor? = nil) {
        super.init(frame: .zero)

        style = activityIndicatorStyle
        self.color = color

        commonInit()
    }

    required init(coder _: NSCoder) {
        fatalError("Can't use decoder")
    }

    func commonInit() {
        sizeToFit()
    }

    func set(valueChanger _: SmoothValueChanger?) {
        // can't set progress for native activity indicator
    }

    func set(progress _: Float) {
        // can't set progress for native activity indicator
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

//        print("touch end")
    }

}
