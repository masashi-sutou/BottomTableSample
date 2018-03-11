//
//  TransitonTypeCell.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

enum TransitonType: Int {
    case push = 0
    case present
}

final class TransitonTypeCell: UITableViewCell {

    private let segment: UISegmentedControl
    private let tapped: (_ selectedTransitonType: TransitonType) -> Void
    
    init(type transitonType: TransitonType, tapped: @escaping (_ selectedTransitonType: TransitonType) -> Void) {
        
        segment = UISegmentedControl(items: ["push", "present"])
        segment.selectedSegmentIndex = transitonType.rawValue
        self.tapped = tapped
        
        super.init(style: .default, reuseIdentifier: type(of: self).className)
        selectionStyle = .none
        accessoryType = .none
        accessoryView = nil

        segment.addTarget(self, action: #selector(tappedSegment(_:)), for: .valueChanged)
        contentView.addSubview(segment, constraints: [
            segment.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            segment.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            segment.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            segment.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tappedSegment(_ sender: UISegmentedControl) {
        tapped(TransitonType(rawValue: sender.selectedSegmentIndex)!)
    }
}
