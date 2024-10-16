//
//  HUD.swift
//  HUD
//
//  Created by Sun on 2022/10/6.
//

import UIKit

import UIExtensions

// MARK: - IHudMode

public protocol IHudMode {
    var id: Int { get }
    var icon: UIImage? { get }
    var iconColor: UIColor { get }
    var title: String? { get }
    var loadingState: Float? { get }
}

// MARK: - HUD

public class HUD {
    // MARK: Static Properties

    public static let shared = HUD()

    // MARK: Properties

    public var config: HUDConfig
    
    public var animated = true

    let keyboardNotificationHandler: HUDKeyboardHelper
    var view: HUDView?

    // MARK: Lifecycle

    init(config: HUDConfig? = nil, keyboardNotifications: HUDKeyboardHelper = .shared) {
        self.config = config ?? HUDConfig()
        keyboardNotificationHandler = keyboardNotifications
    }

    // MARK: Functions

    public func show(error: String?) {
        HUDStatusFactory.shared.config.dismissTimeInterval = 2
        let content = HUDStatusFactory.shared.view(type: .error, title: error)
        showHUD(content, onTapHUD: { hud in
            hud.hide()
        })
    }
    
    public func showHUD(
        _ content: UIView & HUDContentViewInterface,
        statusBarStyle: UIStatusBarStyle? = nil,
        animated: Bool = true,
        showCompletion: (() -> Void)? = nil,
        dismissCompletion: (() -> Void)? = nil,
        onTapCoverView: ((HUD) -> Void)? = nil,
        onTapHUD: ((HUD) -> Void)? = nil
    ) {
        self.animated = animated
        
        let maxSize = CGSize(
            width: UIScreen.main.bounds.width * config.allowedMaximumSize.width,
            height: UIScreen.main.bounds.height * config.allowedMaximumSize.height
        )
        
        if let view {
            view.set(config: config)
            
            view.containerView.setContent(
                content: content,
                preferredSize: config.preferredSize,
                maxSize: maxSize,
                exact: config.exactSize
            )
            view.adjustPlace()
        } else { // if it's no view, create new and show
            guard let windowScene = UIWindow.keyWindow?.windowScene else {
                return
            }
            let coverWindow = DimHUDWindow(windowScene: windowScene, config: config)
            coverWindow.set(transparent: config.userInteractionEnabled)
            
            coverWindow.onTap = { [weak self] in
                if let weakSelf = self {
                    onTapCoverView?(weakSelf)
                }
            }
            
            let containerView = HUDContainerView(withModel: config)
            containerView.onTapContainer = { [weak self] in
                if let weakSelf = self {
                    onTapHUD?(weakSelf)
                }
            }
            containerView.isHidden = true
            containerView.setContent(
                content: content,
                preferredSize: config.preferredSize,
                maxSize: maxSize,
                exact: config.exactSize
            )
            
            view = HUD.create(
                config: config,
                router: self,
                backgroundWindow: coverWindow,
                containerView: containerView,
                statusBarStyle: statusBarStyle
            )
            view?.keyboardNotificationHandler = keyboardNotificationHandler
            
            if content.actions.firstIndex(where: { $0.type == .show }) == nil {
                show()
            }
        }
        view?.presenter.addActionTimers(content.actions)
        view?.showCompletion = showCompletion
        view?.dismissCompletion = dismissCompletion
    }
}

// MARK: HUDViewRouterInterface

extension HUD: HUDViewRouterInterface {
    class func create(
        config: HUDConfig,
        router: HUDViewRouterInterface,
        backgroundWindow: BackgroundHUDWindow,
        containerView: HUDContainerView,
        statusBarStyle: UIStatusBarStyle? = nil
    )
        -> HUDView {
        let interactor: HUDViewInteractorInterface = HUDViewInteractor()
        let presenter: HUDViewPresenterInterface & HUDViewInteractorDelegate = HUDViewPresenter(
            interactor: interactor,
            router: router,
            coverView: backgroundWindow.coverView,
            containerView: containerView,
            config: config
        )
        let view = HUDView(
            presenter: presenter,
            config: config,
            backgroundWindow: backgroundWindow,
            containerView: containerView,
            statusBarStyle: statusBarStyle
        )
        
        presenter.feedbackGenerator = HapticGenerator.shared
        presenter.view = view
        interactor.delegate = presenter
        
        guard let windowScene = UIWindow.keyWindow?.windowScene else {
            return view
        }
        let window = HUDWindow(windowScene: windowScene, rootController: view)
        view.window = window
        
        view.place()
        
        return view
    }
    
    public func show(
        config: HUDConfig,
        viewItem: ViewItem,
        statusBarStyle: UIStatusBarStyle? = nil,
        forced: Bool = false
    ) {
        self.config = config
        let showBlock = { [weak self] in
            let contentView = TopHUDContentView()
            contentView.title = viewItem.title
            contentView.numberOfLines = config.numberOfLines
            contentView.icon = viewItem.icon
            contentView.iconColor = viewItem.iconColor
            contentView.isLoading = viewItem.isLoading
            
            if let showingTime = viewItem.showingTime {
                contentView.actions.append(HUDTimeAction(type: .dismiss, interval: showingTime))
            }
            
            self?.showHUD(contentView, statusBarStyle: statusBarStyle, onTapHUD: { hud in
                hud.hide()
            })
        }
        
        if forced, let view {
            view.hide(animated: true) {
                showBlock()
            }
        } else {
            showBlock()
        }
    }
    
    public func show() {
        view?.presenter.show(animated: animated, completion: { [weak view] in
            view?.showCompletion?()
        })
    }
    
    public func hide() {
        view?.presenter.dismiss(animated: animated, completion: { [weak view, weak self] in
            view?.dismissCompletion?()
            self?.view = nil
        })
    }
}

// MARK: HUD.ViewItem

extension HUD {
    public struct ViewItem {
        // MARK: Properties

        let icon: UIImage?
        let iconColor: UIColor
        let title: String?
        let showingTime: TimeInterval?
        let isLoading: Bool

        // MARK: Lifecycle

        public init(
            icon: UIImage?,
            iconColor: UIColor,
            title: String?,
            showingTime: TimeInterval? = 2,
            isLoading: Bool = false
        ) {
            self.icon = icon
            self.iconColor = iconColor
            self.title = title
            self.showingTime = showingTime
            self.isLoading = isLoading
        }
    }
}
