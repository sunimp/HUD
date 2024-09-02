//
//  HUDViewModule.swift
//
//  Created by Sun on 2021/11/30.
//

import UIKit

// MARK: - HUDViewInterface

protocol HUDViewInterface: AnyObject {
    var presenter: HUDViewPresenterInterface { get }

    func adjustPlace()
    var showCompletion: (() -> Void)? { get set }
    var dismissCompletion: (() -> Void)? { get set }
    func safeCorrectedOffset(for inset: CGPoint, style: HUDBannerStyle?, relativeWindow: Bool) -> CGPoint
}

// MARK: - HUDViewRouterInterface

protocol HUDViewRouterInterface: AnyObject {
    var view: HUDView? { get set }
    func show()
    func hide()
}

// MARK: - HUDViewPresenterInterface

protocol HUDViewPresenterInterface: AnyObject {
    var interactor: HUDViewInteractorInterface { get }
    var view: HUDViewInterface? { get set }
    var feedbackGenerator: HUDFeedbackGenerator? { get set }

    func viewDidLoad()
    func addActionTimers(_ timeActions: [HUDTimeAction])
    func updateCover()
    func show(animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

// MARK: - HUDViewInteractorInterface

protocol HUDViewInteractorInterface: AnyObject {
    var delegate: HUDViewInteractorDelegate? { get set }
}

// MARK: - HUDViewInteractorDelegate

protocol HUDViewInteractorDelegate: AnyObject {
    func updateCover()
    func showContainerView(animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}
