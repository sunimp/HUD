//
//  ComponentView.swift
//  iOS Example
//
//  Created by Sun on 2024/9/6.
//

import UIKit

import SnapKit
import ThemeKit

protocol Resetable {
    func reset()
}

enum Config {
    static let titleFont: UIFont = .subhead1
    static let titleColor: UIColor = .zx001
    static let valueColor: UIColor = .cg005
    static let separatorColor: UIColor = .zx006
    
    static let spacing: CGFloat = 8
    static let margin: CGFloat = 12
}

class Segment<T>: UIView, Resetable {
    
    typealias SelectHandler = ((T) -> Void)
    
    private let title: String
    private let items: [String]
    
    private let titleLabel = UILabel()
    private let segmentControl = UISegmentedControl()
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = Config.separatorColor
        return view
    }()
    
    private let values: [T]
    private let defaultIndex: Int
    private(set) var currentValue: T
    
    private let didSelect: SelectHandler?
    
    init(_ title: String, items: [String], values: [T], defaultIndex: Int = 0, didSelect: SelectHandler? = nil) {
        self.title = title
        self.items = items
        self.values = values
        self.currentValue = values[defaultIndex]
        self.defaultIndex = defaultIndex
        self.didSelect = didSelect
        
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        titleLabel.text = self.title
        addSubview(titleLabel)
        titleLabel.font = Config.titleFont
        titleLabel.textColor = Config.titleColor
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        self.items.enumerated().forEach {
            self.segmentControl.insertSegment(withTitle: $1, at: $0, animated: false)
        }
        addSubview(segmentControl)
        segmentControl.selectedSegmentIndex = defaultIndex
        segmentControl.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Config.spacing)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(Config.margin)
            make.trailing.lessThanOrEqualToSuperview()
        }
        
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func reset() {
        self.currentValue = self.values[self.defaultIndex]
        self.segmentControl.selectedSegmentIndex = self.defaultIndex
        self.didSelect?(self.currentValue)
    }
    
    @objc
    private func handleValueChange(_ sender: UISegmentedControl) {
        let newValue = self.values[sender.selectedSegmentIndex]
        self.currentValue = newValue
        self.didSelect?(newValue)
    }
}

protocol SliderValue: Comparable {
    
    var floatValue: Float { get set }
    
    var stringValue: String { get }
}

extension SliderValue {
    
    var stringValue: String {
        String(format: "%.2f", self.floatValue)
    }
}

extension Int: SliderValue {
    
    var floatValue: Float {
        get {
            Float(self)
        }
        set {
            self = Int(newValue)
        }
    }
    
    var stringValue: String {
        "\(self)"
    }
}

extension CGFloat: SliderValue {
    
    var floatValue: Float {
        get {
            Float(self)
        }
        set {
            self = CGFloat(newValue)
        }
    }
}

extension Float: SliderValue {
    
    var floatValue: Float {
        get {
            self
        }
        set {
            self = newValue
        }
    }
}

extension TimeInterval: SliderValue {
    
    var floatValue: Float {
        get {
            Float(self)
        }
        set {
            self = TimeInterval(newValue)
        }
    }
}

class Slider<T: SliderValue>: UIView, Resetable {
    
    typealias SelectHandler = ((T) -> Void)
    
    private let title: String
    private let range: ClosedRange<T>
    private var maxValue: Float {
        range.upperBound.floatValue
    }
    private var minValue: Float {
        range.lowerBound.floatValue
    }
    
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let slider = UISlider()
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = Config.separatorColor
        return view
    }()
    
    private let defaultValue: T
    private(set) var currentValue: T {
        didSet {
            self.valueLabel.text = self.currentValue.stringValue
        }
    }
    
    private let didSelect: SelectHandler?
    
    init(_ title: String, range: ClosedRange<T>, defaultValue: T, didSelect: SelectHandler? = nil) {
        self.title = title
        self.range = range
        self.currentValue = defaultValue
        self.defaultValue = defaultValue
        self.didSelect = didSelect
        
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        titleLabel.text = self.title
        addSubview(titleLabel)
        titleLabel.font = Config.titleFont
        titleLabel.textColor = Config.titleColor
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        valueLabel.text = self.defaultValue.stringValue
        addSubview(valueLabel)
        valueLabel.font = Config.titleFont
        valueLabel.textColor = Config.valueColor
        valueLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview()
        }
        
        addSubview(slider)
        slider.value = (self.defaultValue.floatValue - minValue) / (maxValue - minValue)
        slider.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        slider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Config.spacing)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(Config.margin)
        }
        
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func reset() {
        self.currentValue = self.defaultValue
        self.slider.value = (self.defaultValue.floatValue - minValue) / (maxValue - minValue)
        self.didSelect?(self.currentValue)
    }
    
    @objc
    private func handleValueChange(_ sender: UISlider) {
        self.currentValue.floatValue = minValue + (sender.value * (maxValue - minValue))
        self.didSelect?(self.currentValue)
    }
}

class Switch: UIView, Resetable {
    
    typealias SelectHandler = ((Bool) -> Void)
    
    private let title: String
    
    private let titleLabel = UILabel()
    private let switcher = UISwitch()
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = Config.separatorColor
        return view
    }()
    
    private let defaultValue: Bool
    private(set) var currentValue: Bool
    
    private let didSelect: SelectHandler?
    
    init(_ title: String, defaultValue: Bool, didSelect: SelectHandler? = nil) {
        self.title = title
        self.currentValue = defaultValue
        self.defaultValue = defaultValue
        self.didSelect = didSelect
        
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        titleLabel.text = self.title
        addSubview(titleLabel)
        titleLabel.font = Config.titleFont
        titleLabel.textColor = Config.titleColor
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        addSubview(switcher)
        switcher.isOn = self.defaultValue
        switcher.addTarget(self, action: #selector(handleValueChange), for: .valueChanged)
        switcher.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Config.spacing)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(Config.margin)
        }
        
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func reset() {
        self.currentValue = self.defaultValue
        self.switcher.isOn = self.defaultValue
        self.didSelect?(self.currentValue)
    }
    
    @objc
    private func handleValueChange(_ sender: UISwitch) {
        self.currentValue = sender.isOn
        self.didSelect?(sender.isOn)
    }
}

class ColorPicker: UIView, Resetable, UIColorPickerViewControllerDelegate {
    
    typealias SelectHandler = ((UIColor) -> Void)
    
    private let title: String
    
    private let titleLabel = UILabel()
    private let indicatorView = UIView()
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = Config.separatorColor
        return view
    }()
    
    private var colorPickerVC: UIColorPickerViewController?
    
    private let defaultColor: UIColor
    private(set) var currentColor: UIColor
    
    private let didSelect: SelectHandler?
    
    init(_ title: String, defaultColor: UIColor, didSelect: SelectHandler? = nil) {
        self.title = title
        self.defaultColor = defaultColor
        self.currentColor = defaultColor
        self.didSelect = didSelect
        
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        titleLabel.text = self.title
        addSubview(titleLabel)
        titleLabel.font = Config.titleFont
        titleLabel.textColor = Config.titleColor
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        addSubview(indicatorView)
        indicatorView.backgroundColor = self.defaultColor
        indicatorView.layer.borderWidth = 1
        indicatorView.layer.borderColor = UIColor.black.cgColor
        indicatorView.layer.cornerRadius = 6
        indicatorView.isUserInteractionEnabled = true
        
        indicatorView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Config.spacing)
            make.leading.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(28)
            make.bottom.equalToSuperview().inset(Config.margin)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapColorPickerView))
        indicatorView.addGestureRecognizer(tapGesture)
        
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func reset() {
        self.indicatorView.backgroundColor = self.defaultColor
        self.currentColor = self.defaultColor
        self.didSelect?(self.currentColor)
    }
    
    @objc
    private func didTapColorPickerView() {
        guard let parentVC = findViewController() else { return }
        
        colorPickerVC = UIColorPickerViewController()
        colorPickerVC?.delegate = self
        colorPickerVC?.selectedColor = self.currentColor
        
        parentVC.present(colorPickerVC!, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.indicatorView.backgroundColor = viewController.selectedColor
        self.currentColor = viewController.selectedColor
        self.didSelect?(viewController.selectedColor)
    }
    
    private func findViewController() -> UIViewController? {
        var nextResponder: UIResponder? = self
        while let responder = nextResponder {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            nextResponder = responder.next
        }
        return nil
    }
}

class Picker<T>: UIView, UIPickerViewDelegate, Resetable, UIPickerViewDataSource {
    
    typealias SelectHandler = ((T) -> Void)
    
    private let title: String
    private let titleLabel = UILabel()
    
    private let pickerView = UIPickerView()
    private let toolBar = UIToolbar()
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = Config.separatorColor
        return view
    }()
    
    private let items: [String]
    
    private let valueLabel = UILabel()
    
    private let values: [T]
    private var selectedIndex: Int
    private(set) var currentValue: T
    private let defaultIndex: Int
    
    private let didSelect: SelectHandler?
    
    init(_ title: String, items: [String], values: [T], defaultIndex: Int, didSelect: SelectHandler? = nil) {
        self.title = title
        self.items = items
        self.values = values
        self.defaultIndex = defaultIndex
        self.selectedIndex = defaultIndex
        self.currentValue = values[defaultIndex]
        self.didSelect = didSelect
        
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        titleLabel.text = self.title
        addSubview(titleLabel)
        titleLabel.font = Config.titleFont
        titleLabel.textColor = Config.titleColor
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }
        
        valueLabel.text = self.items[self.defaultIndex]
        valueLabel.textAlignment = .center
        valueLabel.textColor = Config.valueColor
        valueLabel.isUserInteractionEnabled = true
        addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Config.spacing)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(Config.margin)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapPickerView))
        valueLabel.addGestureRecognizer(tapGesture)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        toolBar.setItems([doneButton], animated: true)
        
        pickerView.selectRow(defaultIndex, inComponent: 0, animated: false)
        
        addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func reset() {
        self.selectedIndex = self.defaultIndex
        self.currentValue = self.values[self.defaultIndex]
        self.valueLabel.text = self.items[self.defaultIndex]
        self.didSelect?(self.currentValue)
    }
    
    @objc
    private func didTapPickerView() {
        let textField = UITextField(frame: .zero)
        textField.inputView = pickerView
        textField.inputAccessoryView = toolBar
        self.addSubview(textField)
        textField.becomeFirstResponder()
    }
    
    @objc 
    private func donePressed() {
        self.valueLabel.text = self.items[self.selectedIndex]
        self.currentValue = self.values[self.selectedIndex]
        self.didSelect?(self.currentValue)
        self.endEditing(true)
    }
    
    // MARK: - UIPickerView 数据源和代理方法
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedIndex = row
    }
}
