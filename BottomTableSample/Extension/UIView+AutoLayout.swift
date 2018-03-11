//
//  UIView+AutoLayout.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/09.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    
    final func priority(_  value: Float) -> NSLayoutConstraint {
        self.priority = .init(value)
        return self
    }
    
    final func activate() {
        self.isActive = true
    }
}

extension UIView {
    
    final func addSubview(_ view: UIView, constraints: [NSLayoutConstraint]) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    final func addSubview(_ view: UIView, height: CGFloat, top: CGFloat) {
        addSubview(view, constraints: [
            view.heightAnchor.constraint(equalToConstant: height),
            view.topAnchor.constraint(equalTo: topAnchor, constant: top),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    final func addSubviewToLeading(_ view: UIView, size: CGSize) {
        addSubview(view, constraints: [
            view.widthAnchor.constraint(equalToConstant: size.width),
            view.heightAnchor.constraint(equalToConstant: size.height),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
            ])
    }
    
    final func addSubviewToTrailing(_ view: UIView, size: CGSize) {
        addSubview(view, constraints: [
            view.widthAnchor.constraint(equalToConstant: size.width),
            view.heightAnchor.constraint(equalToConstant: size.height),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
            ])
    }
}
