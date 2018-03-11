//
//  TextViewCell.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/10.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class TextViewCell: UITableViewCell, UITextViewDelegate {
    
    let textView: UITextView = UITextView(frame: .zero)
    private let placeholderLabel: UILabel = UILabel()
    private let textChanged: (String) -> Void
    private let tappedNext: () -> Void
    static var preferredHeight: CGFloat {
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        if screenHeight == 480 {
            return 100
        } else if screenHeight == 568 {
            return 130
        } else if screenHeight <= 667 {
            return 160
        } else {
            return 200
        }
    }
    
    init(placeholder: String, textChanged: @escaping (String) -> Void, tappedNext: @escaping () -> Void) {
        
        self.textChanged = textChanged
        self.tappedNext = tappedNext
        
        super.init(style: .default, reuseIdentifier: type(of: self).className)
        selectionStyle = .none
        accessoryType = .none
        accessoryView = nil

        setupSubViews(placeholder: placeholder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews(placeholder: String) {
        
        textView.delegate = self
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.isScrollEnabled = true
        textView.font = .preferredFont(forTextStyle: .body)
        contentView.addSubview(textView, constraints: [
            textView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: type(of: self).preferredHeight).priority(999)
            ])
        
        setupInputAccessoryView()
        
        placeholderLabel.font = .preferredFont(forTextStyle: .body)
        placeholderLabel.textColor = .unable
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        contentView.addSubview(placeholderLabel, constraints: [
            placeholderLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            placeholderLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            placeholderLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])
        
        visiblePlaceholder()
    }
    
    // MARK: - Placeholder
    
    private func visiblePlaceholder() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        visiblePlaceholder()
        textChanged(textView.text)
    }
    
    // MARK: - InputAccessoryView
    
    private func setupInputAccessoryView() {
        
        let inputAccessoryView = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        inputAccessoryView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 44)
        textView.inputAccessoryView = inputAccessoryView
        
        let buttonSize: CGSize = CGSize(width: 88, height: 44)
        let closeButton = UIButton(type: .custom)
        closeButton.backgroundColor = .clear
        closeButton.setTitleColor(.defaultTint, for: .normal)
        closeButton.setTitleColor(.defaultTintHighlighted, for: .highlighted)
        closeButton.setTitle("close", for: .normal)
        closeButton.addTarget(self, action: #selector(tappedCloseButtonInAccessoryView(_:)), for: .touchUpInside)
        inputAccessoryView.contentView.addSubviewToLeading(closeButton, size: buttonSize)
        
        let nextButton = UIButton(type: .custom)
        nextButton.backgroundColor = .clear
        nextButton.setTitleColor(.defaultTint, for: .normal)
        nextButton.setTitleColor(.defaultTintHighlighted, for: .highlighted)
        nextButton.setTitle("next", for: .normal)
        nextButton.addTarget(self, action: #selector(tappedNextButtonInAccessoryView(_:)), for: .touchUpInside)
        inputAccessoryView.contentView.addSubviewToTrailing(nextButton, size: buttonSize)
    }
    
    @objc private func tappedCloseButtonInAccessoryView(_ sender: UIButton) {
        textView.resignFirstResponder()
    }
    
    @objc private func tappedNextButtonInAccessoryView(_ sender: UIButton) {
        tappedNext()
    }
}
