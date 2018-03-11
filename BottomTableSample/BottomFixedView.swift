//
//  BottomFixedView.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/09.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class BottomFixedView: UIVisualEffectView {
    
    private let space: CGFloat = 15
    private let viewSize: CGSize = CGSize(width: 280, height: 44)
    private let borderHeight: CGFloat = 1 / UIScreen.main.scale
    private let border: UIView
    private var views: [UIView]
    
    var preferredHeight: CGFloat {
        if frame.height <= borderHeight {
            return space + (viewSize.height + space) * CGFloat(views.count)
        } else {
            return isHidden ? 0 : frame.height
        }
    }
    
    init(views: [UIView]) {
        self.views = views
        self.border = UIView()
        super.init(effect: UIBlurEffect(style: .extraLight))
        border.backgroundColor = .unable
        contentView.addSubview(border, height: borderHeight, top: borderHeight)
        views.forEach { contentView.addSubview($0) }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        views.enumerated().forEach {
            let point: CGPoint = CGPoint(x: (frame.width - viewSize.width) / 2,
                                         y: space + (viewSize.height + space) * CGFloat($0.offset))
            $0.element.frame = CGRect(origin: point, size: viewSize)
        }
    }
}
