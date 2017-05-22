//
//  TLTextFieldItem.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/19/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import UIKit

class TLTextFieldItemCell: UICollectionViewCell {
    
    fileprivate let leadingSpacing: CGFloat = 15
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
        label.font = TLFontHelper.title
        label.textColor = TLColorPalette.titleColor
        label.numberOfLines = 1
        return label
    }()
    
    fileprivate lazy var inputTextField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = TLFontHelper.inputText
        textfield.textColor = TLColorPalette.textColor
        textfield.addTarget(self, action: #selector(inputTextDidEdit(sender:)), for: .editingChanged)
        return textfield
    }()
    
    var cellModel: TLTextFieldItemCellModel
    
    var titleText: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var inputText: String? {
        get {
            return inputTextField.text
        }
        set {
            inputTextField.text = newValue
        }
    }
    
    var placeholderText: String? {
        get {
            return inputTextField.placeholder
        }
        set {
            inputTextField.placeholder = newValue
        }
    }
    
    fileprivate(set) var itemSetup: TLTextFieldItemSetup?
    
    override init(frame: CGRect) {
        cellModel = TLTextFieldItemCellModel(inputText: nil)
        super.init(frame: frame)
        setupTitleLabel()
        setupInputTextField()
        backgroundColor = TLColorPalette.backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func inputTextDidEdit(sender: UITextField) {
        cellModel.inputText = sender.text
    }
 
    static func createItem(from collectionView: UICollectionView, for indexPath: IndexPath, identifier: String, itemSetup: TLTextFieldItemSetup, model: TLTextFieldItemCellModel) -> TLTextFieldItemCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TLTextFieldItemCell
        cell.setup(itemSetup: itemSetup)
        cell.titleText = itemSetup.titleText
        cell.placeholderText = itemSetup.placeholderText
        cell.inputText = model.inputText
        cell.cellModel.didChangeText = model.didChangeText
        return cell
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let drawSeparator = self.itemSetup?.drawSeparator ?? false
        let color = self.itemSetup?.separatorColor ?? UIColor.darkGray
        let width = self.itemSetup?.separatorWidth ?? 0.5
        
        if drawSeparator {
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: leadingSpacing, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.lineWidth = width
            color.setStroke()
            path.stroke()
            path.close()
            
        }
    }
    
}

extension TLTextFieldItemCell {
    
    internal func setup(itemSetup: TLTextFieldItemSetup) {
        
        self.itemSetup = itemSetup
        
        backgroundColor = itemSetup.backgroundColor
        
        if let titleColor = itemSetup.titleColor {
            titleLabel.textColor = titleColor
        }
        
        if let titleFont = itemSetup.titleFont {
            titleLabel.font = titleFont
        }
        
        if let inputColor = itemSetup.inputColor {
            inputTextField.textColor = inputColor
        }
        
        if let inputFont = itemSetup.inputFont {
            inputTextField.font = inputFont
        }
    }
    
    fileprivate func setupTitleLabel() {
        
        addSubview(titleLabel)
        
        NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: leadingSpacing).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -leadingSpacing).isActive = true
    }
    
    fileprivate func setupInputTextField() {
        
        addSubview(inputTextField)
        
        NSLayoutConstraint(item: inputTextField, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 1).isActive = true
        NSLayoutConstraint(item: inputTextField, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: inputTextField, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: inputTextField, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10).isActive = true
    }
    
}
