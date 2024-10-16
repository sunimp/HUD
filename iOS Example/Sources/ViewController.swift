//
//  ViewController.swift
//  HUD-Example
//
//  Created by Sun on 2024/8/23.
//

import UIKit

import HUD
import UIExtensions

class ViewController: UIViewController {
    
    static let optionDuration: TimeInterval = 0.2
    
    private lazy var styleSegment: Segment<HUDStyle> = {
        let view = Segment<HUDStyle>(
            "HUD Style",
            items: ["Banner", "Center"],
            values: [.banner(.top), .center],
            didSelect: { [weak self] _ in
                self?.updateOptions()
            }
        )
        return view
    }()
    
    private var hudStyle: HUDStyle {
        switch self.styleSegment.currentValue {
        case .center:
            return self.styleSegment.currentValue
        case .banner:
            return .banner(self.bannerStyleSegment.currentValue)
        }
    }
    
    private lazy var bannerStyleSegment: Segment<HUDBannerStyle> = {
        let view = Segment<HUDBannerStyle>(
            "Banner Style",
            items: ["Top", "Left", "Bottom", "Right"],
            values: [.top, .left, .bottom, .right]
        )
        return view
    }()
    
    private lazy var appearStyleSegment: Segment<HUDAppearStyle> = {
        let view = Segment<HUDAppearStyle>(
            "Appear Style",
            items: ["MoveOut", "AlphaAppear", "SizeAppear"],
            values: [.moveOut, .alphaAppear, .sizeAppear(.both)],
            didSelect: { [weak self] _ in
                self?.updateOptions()
            }
        )
        return view
    }()
    
    private var appearStyle: HUDAppearStyle {
        switch self.appearStyleSegment.currentValue {
        case .moveOut, .alphaAppear:
            return self.appearStyleSegment.currentValue
        case .sizeAppear:
            return .sizeAppear(self.sizeAppearStyleSegment.currentValue)
        }
    }
    
    private lazy var sizeAppearStyleSegment: Segment<HUDSizeAppearStyle> = {
        let view = Segment<HUDSizeAppearStyle>(
            "Size Appear Style",
            items: ["Horizontal", "Vertical", "Both"],
            values: [.horizontal, .vertical, .both],
            defaultIndex: 2
        )
        return view
    }()
    
    private lazy var startAdjustSizeSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Start Adjust Size", range: 0...1.0, defaultValue: 0.8)
        return view
    }()
    
    private lazy var finishAdjustSizeSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Finish Adjust Size", range: 0...1.0, defaultValue: 1.0)
        return view
    }()
    
    private lazy var exactSizeSwitch: Switch = {
        let view = Switch("Exact Size", defaultValue: false) { [weak self] _ in
            self?.updateOptions()
        }
        return view
    }()
    
    private lazy var preferredWidthSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Preferred Width", range: 1...view.bounds.width, defaultValue: 114)
        return view
    }()
    
    private lazy var preferredHeightSilder: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Preferred Height", range: 1...view.bounds.height, defaultValue: 56)
        return view
    }()
    
    private lazy var allowedMaximumWidthSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Allowed Maximum Width", range: 0...1.0, defaultValue: 0.8)
        return view
    }()
    
    private lazy var allowedMaximumHeightSilder: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Allowed Maximum Height", range: 0...1.0, defaultValue: 0.8)
        return view
    }()
    
    private lazy var hudInsetXSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("HUD Inset X", range: -100...100.0, defaultValue: 0)
        return view
    }()
    
    private lazy var hudInsetYSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("HUD Inset Y", range: -100...100.0, defaultValue: 24)
        return view
    }()
    
    private lazy var absoluteInsetsSwitch: Switch = {
        let view = Switch("Absolute Insets", defaultValue: false)
        return view
    }()
    
    private lazy var numberOfLinesSlider: Slider<Int> = {
        let view = Slider<Int>("Number Of Lines", range: 0...100, defaultValue: 0)
        return view
    }()
    
    private lazy var coverInAnimationDurationSlider: Slider<TimeInterval> = {
        let view = Slider<TimeInterval>("Cover In Animation Duration", range: 0...2, defaultValue: 0.3)
        return view
    }()
    
    private lazy var coverOutAnimationDurationSlider: Slider<TimeInterval> = {
        let view = Slider<TimeInterval>("Cover Out Animation Duration", range: 0...2, defaultValue: 0.35)
        return view
    }()
    
    private lazy var coverAnimationCurvePicker: Picker<UIView.AnimationOptions> = {
        let view = Picker<UIView.AnimationOptions>(
            "Cover Animation Curve",
            items: [
                "LayoutSubviews",
                "AllowUserInteraction",
                "BeginFromCurrentState",
                "Repeat",
                "Autoreverse",
                "OverrideInheritedDuration",
                "OverrideInheritedCurve",
                "AllowAnimatedContent",
                "ShowHideTransitionViews",
                "OverrideInheritedOptions",
                "CurveEaseInOut",
                "CurveEaseIn",
                "CurveEaseOut",
                "CurveLinear",
                "TransitionFlipFromLeft",
                "TransitionFlipFromRight",
                "TransitionCurlUp",
                "TransitionCurlDown",
                "TransitionCrossDissolve",
                "TransitionFlipFromTop",
                "TransitionFlipFromBottom",
                "PreferredFramesPerSecond60",
                "PreferredFramesPerSecond30"
            ],
            values: [
                .layoutSubviews,
                .allowUserInteraction,
                .beginFromCurrentState,
                .repeat,
                .autoreverse,
                .overrideInheritedDuration,
                .overrideInheritedCurve,
                .allowAnimatedContent,
                .showHideTransitionViews,
                .overrideInheritedOptions,
                .curveEaseInOut,
                .curveEaseIn,
                .curveEaseOut,
                .curveLinear,
                .transitionFlipFromLeft,
                .transitionFlipFromRight,
                .transitionCurlUp,
                .transitionCurlDown,
                .transitionCrossDissolve,
                .transitionFlipFromTop,
                .transitionFlipFromBottom,
                .preferredFramesPerSecond60,
                .preferredFramesPerSecond30
            ],
            defaultIndex: 10
        )
        return view
    }()
    
    private lazy var coverBackgroundColorPicker: ColorPicker = {
        let view = ColorPicker("Cover Background Color", defaultColor: .zx013)
        return view
    }()
    
    private lazy var coverBlurEffectStylePicker: Picker<UIBlurEffect.Style> = {
        let view = Picker<UIBlurEffect.Style>(
            "Cover BlurEffect Style",
            items: [
                "ExtraLight",
                "Light",
                "Dark",
                "Regular",
                "Prominent",
                "SystemUltraThinMaterial",
                "SystemThinMaterial",
                "SystemMaterial",
                "SystemThickMaterial",
                "SystemChromeMaterial",
                "SystemUltraThinMaterialLight",
                "SystemThinMaterialLight",
                "SystemMaterialLight",
                "SystemThickMaterialLight",
                "SystemChromeMaterialLight",
                "SystemUltraThinMaterialDark",
                "SystemThinMaterialDark",
                "SystemMaterialDark",
                "SystemThickMaterialDark",
                "SystemChromeMaterialDark"
            ],
            values: [
                .extraLight,
                .light,
                .dark,
                .regular,
                .prominent,
                .systemUltraThinMaterial,
                .systemThinMaterial,
                .systemMaterial,
                .systemThickMaterial,
                .systemChromeMaterial,
                .systemUltraThinMaterialLight,
                .systemThinMaterialLight,
                .systemMaterialLight,
                .systemThickMaterialLight,
                .systemChromeMaterialLight,
                .systemUltraThinMaterialDark,
                .systemThinMaterialDark,
                .systemMaterialDark,
                .systemThickMaterialDark,
                .systemChromeMaterialDark
            ],
            defaultIndex: 1
        )
        return view
    }()
    
    private lazy var coverBlurEffectIntensitySlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Cover Blur Effect Intensity", range: 0...1, defaultValue: 0.1)
        return view
    }()
    
    private lazy var userInteractionEnabledSwitch: Switch = {
        let view = Switch("User Interaction Enabled", defaultValue: true)
        return view
    }()
    
    private lazy var handleKeyboardSegment: Segment<HUDHandleKeyboardType> = {
        let view = Segment<HUDHandleKeyboardType>(
            "Handle Keyboard Type",
            items: ["StartPosition", "Always", "None"],
            values: [.startPosition, .always, .none],
            defaultIndex: 0
        )
        return view
    }()
    
    public lazy var inAnimationDurationSlider: Slider<TimeInterval> = {
        let view = Slider<TimeInterval>("In Animation Duration", range: 0...2, defaultValue: 0.3)
        return view
    }()
    
    public lazy var outAnimationDurationSlider: Slider<TimeInterval> = {
        let view = Slider<TimeInterval>("Out Animation Duration", range: 0...2, defaultValue: 0.3)
        return view
    }()
    
    public lazy var animationCurvePicker: Picker<UIView.AnimationOptions> = {
        let view = Picker<UIView.AnimationOptions>(
            "Animation Curve",
            items: [
                "LayoutSubviews",
                "AllowUserInteraction",
                "BeginFromCurrentState",
                "Repeat",
                "Autoreverse",
                "OverrideInheritedDuration",
                "OverrideInheritedCurve",
                "AllowAnimatedContent",
                "ShowHideTransitionViews",
                "OverrideInheritedOptions",
                "CurveEaseInOut",
                "CurveEaseIn",
                "CurveEaseOut",
                "CurveLinear",
                "TransitionFlipFromLeft",
                "TransitionFlipFromRight",
                "TransitionCurlUp",
                "TransitionCurlDown",
                "TransitionCrossDissolve",
                "TransitionFlipFromTop",
                "TransitionFlipFromBottom",
                "PreferredFramesPerSecond60",
                "PreferredFramesPerSecond30"
            ],
            values: [
                .layoutSubviews,
                .allowUserInteraction,
                .beginFromCurrentState,
                .repeat,
                .autoreverse,
                .overrideInheritedDuration,
                .overrideInheritedCurve,
                .allowAnimatedContent,
                .showHideTransitionViews,
                .overrideInheritedOptions,
                .curveEaseInOut,
                .curveEaseIn,
                .curveEaseOut,
                .curveLinear,
                .transitionFlipFromLeft,
                .transitionFlipFromRight,
                .transitionCurlUp,
                .transitionCurlDown,
                .transitionCrossDissolve,
                .transitionFlipFromTop,
                .transitionFlipFromBottom,
                .preferredFramesPerSecond60,
                .preferredFramesPerSecond30
            ],
            defaultIndex: 12
        )
        return view
    }()
    
    private lazy var cornerRadiusSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Corner Radius", range: 0...50, defaultValue: 28)
        return view
    }()
    
    private lazy var blurEffectStylePicker: Picker<UIBlurEffect.Style> = {
        let view = Picker<UIBlurEffect.Style>(
            "BlurEffect Style",
            items: [
                "ExtraLight",
                "Light",
                "Dark",
                "Regular",
                "Prominent",
                "SystemUltraThinMaterial",
                "SystemThinMaterial",
                "SystemMaterial",
                "SystemThickMaterial",
                "SystemChromeMaterial",
                "SystemUltraThinMaterialLight",
                "SystemThinMaterialLight",
                "SystemMaterialLight",
                "SystemThickMaterialLight",
                "SystemChromeMaterialLight",
                "SystemUltraThinMaterialDark",
                "SystemThinMaterialDark",
                "SystemMaterialDark",
                "SystemThickMaterialDark",
                "SystemChromeMaterialDark"
            ],
            values: [
                .extraLight,
                .light,
                .dark,
                .regular,
                .prominent,
                .systemUltraThinMaterial,
                .systemThinMaterial,
                .systemMaterial,
                .systemThickMaterial,
                .systemChromeMaterial,
                .systemUltraThinMaterialLight,
                .systemThinMaterialLight,
                .systemMaterialLight,
                .systemThickMaterialLight,
                .systemChromeMaterialLight,
                .systemUltraThinMaterialDark,
                .systemThinMaterialDark,
                .systemMaterialDark,
                .systemThickMaterialDark,
                .systemChromeMaterialDark
            ],
            defaultIndex: 5
        )
        return view
    }()
    
    private lazy var blurEffectIntensitySlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Blur Effect Intensity", range: 0...1, defaultValue: 0.4)
        return view
    }()
    
    private lazy var backgroundColorPicker: ColorPicker = {
        let view = ColorPicker("Background Color", defaultColor: .zx007)
        return view
    }()
    
    private lazy var shadowRadiusSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Shadow Radius", range: 0...20, defaultValue: 0)
        return view
    }()
    
    private lazy var borderWidthSlider: Slider<CGFloat> = {
        let view = Slider<CGFloat>("Border Width", range: 0...20, defaultValue: 0)
        return view
    }()
    
    private lazy var borderColorPicker: ColorPicker = {
        let view = ColorPicker("Border Color", defaultColor: .darkGray)
        return view
    }()

    private lazy var hapticTypeSegment: Segment<HapticNotificationType> = {
        let view = Segment<HapticNotificationType>(
            "Haptic Notification Type",
            items: ["Error", "Success", "Warning", "Feedback"],
            values: [.error, .success, .warning, .feedback(.light)],
            defaultIndex: 0) { [weak self] _ in
                self?.updateOptions()
            }
        return view
    }()
    
    private var hapticType: HapticNotificationType {
        switch self.hapticTypeSegment.currentValue {
        case .error, .success, .warning:
            return self.hapticTypeSegment.currentValue
        case .feedback:
            return .feedback(self.feedbackStyleSegment.currentValue)
        }
    }
    
    private lazy var feedbackStyleSegment: Segment<UIImpactFeedbackGenerator.FeedbackStyle> = {
        let view = Segment<UIImpactFeedbackGenerator.FeedbackStyle>(
            "Feedback Style",
            items: ["Light", "Medium", "Heavy", "Soft", "Rigid"],
            values: [.light, .medium, .heavy, .soft, .rigid],
            defaultIndex: 0
        )
        return view
    }()
    
    public lazy var showingTimeSlider: Slider<TimeInterval> = {
        let view = Slider<TimeInterval>("Showing Time", range: 1...10, defaultValue: 2)
        return view
    }()
    
    private lazy var forceShowSwitch: Switch = {
        let view = Switch("Force Show", defaultValue: true)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "HUD Demo"
        self.navigationItem.largeTitleDisplayMode = .never
        
        let resetButton = UIButton()
        resetButton.setTitleColor(.systemRed, for: .normal)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        let resetItem = UIBarButtonItem(customView: resetButton)
        navigationItem.leftBarButtonItems = [resetItem]
        
        let showButton = UIButton()
        showButton.setTitleColor(.systemBlue, for: .normal)
        showButton.setTitle("Show", for: .normal)
        showButton.addTarget(self, action: #selector(showHUD), for: .touchUpInside)
        let showItem = UIBarButtonItem(customView: showButton)
        navigationItem.rightBarButtonItems = [showItem]
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Config.spacing
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }

        stackView.addArrangedSubviews([
            styleSegment,
            bannerStyleSegment,
            appearStyleSegment,
            sizeAppearStyleSegment,
            startAdjustSizeSlider,
            finishAdjustSizeSlider,
            exactSizeSwitch,
            preferredWidthSlider,
            preferredHeightSilder,
            allowedMaximumWidthSlider,
            allowedMaximumHeightSilder,
            hudInsetXSlider,
            hudInsetYSlider,
            absoluteInsetsSwitch,
            numberOfLinesSlider,
            coverInAnimationDurationSlider,
            coverOutAnimationDurationSlider,
            coverAnimationCurvePicker,
            coverBackgroundColorPicker,
            coverBlurEffectStylePicker,
            coverBlurEffectIntensitySlider,
            userInteractionEnabledSwitch,
            handleKeyboardSegment,
            inAnimationDurationSlider,
            outAnimationDurationSlider,
            animationCurvePicker,
            cornerRadiusSlider,
            blurEffectStylePicker,
            blurEffectIntensitySlider,
            backgroundColorPicker,
            shadowRadiusSlider,
            borderWidthSlider,
            borderColorPicker,
            hapticTypeSegment,
            feedbackStyleSegment,
            showingTimeSlider,
            forceShowSwitch
        ])
        
        updateOptions()
    }
    
    @objc
    private func showHUD() {
        show(title: "Hello World")
    }
    
    @objc
    private func reset() {
        let resetable: [Resetable] = [
            styleSegment,
            bannerStyleSegment,
            appearStyleSegment,
            sizeAppearStyleSegment,
            startAdjustSizeSlider,
            finishAdjustSizeSlider,
            exactSizeSwitch,
            preferredWidthSlider,
            preferredHeightSilder,
            allowedMaximumWidthSlider,
            allowedMaximumHeightSilder,
            hudInsetXSlider,
            hudInsetYSlider,
            absoluteInsetsSwitch,
            numberOfLinesSlider,
            coverInAnimationDurationSlider,
            coverOutAnimationDurationSlider,
            coverAnimationCurvePicker,
            coverBackgroundColorPicker,
            coverBlurEffectStylePicker,
            coverBlurEffectIntensitySlider,
            userInteractionEnabledSwitch,
            handleKeyboardSegment,
            inAnimationDurationSlider,
            outAnimationDurationSlider,
            animationCurvePicker,
            cornerRadiusSlider,
            blurEffectStylePicker,
            blurEffectIntensitySlider,
            backgroundColorPicker,
            shadowRadiusSlider,
            borderWidthSlider,
            borderColorPicker,
            hapticTypeSegment,
            feedbackStyleSegment,
            showingTimeSlider,
            forceShowSwitch
        ]
        resetable.forEach { $0.reset() }
        updateOptions()
    }
    
    private func updateOptions() {
        UIView.animate(withDuration: Self.optionDuration) {
            if case .center = self.hudStyle {
                self.bannerStyleSegment.setHidden(true)
            } else {
                self.bannerStyleSegment.setHidden(false)
            }
            switch self.appearStyle {
            case .moveOut, .alphaAppear:
                self.sizeAppearStyleSegment.setHidden(true)
            case .sizeAppear:
                self.sizeAppearStyleSegment.setHidden(false)
            }
            self.preferredWidthSlider.setHidden(!self.exactSizeSwitch.currentValue)
            self.preferredHeightSilder.setHidden(!self.exactSizeSwitch.currentValue)
            switch self.hapticType {
            case .error, .success, .warning:
                self.feedbackStyleSegment.setHidden(true)
            case .feedback:
                self.feedbackStyleSegment.setHidden(false)
            }
        }
    }
    
    private func show(title: String?) {
        var config = HUDConfig()
        
        config.style = self.hudStyle
        config.appearStyle = self.appearStyle
        
        config.startAdjustSize = self.startAdjustSizeSlider.currentValue
        config.finishAdjustSize = self.finishAdjustSizeSlider.currentValue
        
        config.exactSize = self.exactSizeSwitch.currentValue
        config.preferredSize = CGSize(
            width: self.preferredWidthSlider.currentValue,
            height: self.preferredHeightSilder.currentValue
        )
        config.allowedMaximumSize = CGSize(
            width: self.allowedMaximumWidthSlider.currentValue,
            height: self.allowedMaximumHeightSilder.currentValue
        )
        config.hudInset = CGPoint(
            x: self.hudInsetXSlider.currentValue,
            y: self.hudInsetYSlider.currentValue
        )
        config.absoluteInsetsValue = self.absoluteInsetsSwitch.currentValue
        
        config.numberOfLines = self.numberOfLinesSlider.currentValue
        
        config.coverInAnimationDuration = self.coverInAnimationDurationSlider.currentValue
        config.coverOutAnimationDuration = self.coverOutAnimationDurationSlider.currentValue
        config.coverAnimationCurve = self.coverAnimationCurvePicker.currentValue
        config.coverBackgroundColor = self.coverBackgroundColorPicker.currentColor
        config.coverBlurEffectStyle = self.coverBlurEffectStylePicker.currentValue
        config.coverBlurEffectIntensity = self.coverBlurEffectIntensitySlider.currentValue
        
        config.userInteractionEnabled = self.userInteractionEnabledSwitch.currentValue
        
        config.handleKeyboard = self.handleKeyboardSegment.currentValue
        
        config.inAnimationDuration = self.inAnimationDurationSlider.currentValue
        config.outAnimationDuration = self.outAnimationDurationSlider.currentValue
        config.animationCurve = self.animationCurvePicker.currentValue
        
        config.cornerRadius = self.cornerRadiusSlider.currentValue
        config.blurEffectStyle = self.blurEffectStylePicker.currentValue
        config.blurEffectIntensity = self.blurEffectIntensitySlider.currentValue
        config.backgroundColor = self.backgroundColorPicker.currentColor
        
        config.shadowRadius = self.shadowRadiusSlider.currentValue
        config.borderColor = self.borderColorPicker.currentColor
        config.borderWidth = self.borderWidthSlider.currentValue
        
        config.hapticType = self.hapticType
        
        let viewItem = HUD.ViewItem(
            icon: UIImage(named: "copy_24")?.tint(.cg001),
            iconColor: .cg001,
            title: title,
            showingTime: self.showingTimeSlider.currentValue,
            isLoading: false
        )
        
        HUD.shared.show(
            config: config,
            viewItem: viewItem,
            forced: self.forceShowSwitch.currentValue
        )
    }
}

extension UIStackView {
    
    func addArrangedSubviews(_ views: [UIView]) {
        self.arrangedSubviews.forEach {
            self.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}

extension UIView {
    
    func setHidden(_ isHidden: Bool) {
        guard self.isHidden != isHidden else {
            return
        }
        self.isHidden = isHidden
    }
}
