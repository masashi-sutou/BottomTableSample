//
//  TextFieldCell.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/10.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class TextFieldCell: UITableViewCell, UITextFieldDelegate {
    
    let textField: UITextField
    private let textChanged: (String) -> Void
    
    init(placeholder: String, textChanged: @escaping (String) -> Void) {

        textField = UITextField(frame: .zero)
        textField.clearButtonMode = .whileEditing
        textField.placeholder = placeholder
        textField.returnKeyType = .done
        self.textChanged = textChanged
        
        super.init(style: .default, reuseIdentifier: type(of: self).className)
        selectionStyle = .none
        accessoryType = .none
        accessoryView = nil
        
        textField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        textField.delegate = self

        contentView.heightAnchor.constraint(equalToConstant: 44).priority(749).activate()
        contentView.addSubview(textField, constraints: [
            textField.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - change text
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textChanged(text)
    }
}
