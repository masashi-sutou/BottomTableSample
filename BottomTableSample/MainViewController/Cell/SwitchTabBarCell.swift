//
//  SwitchTabBarCell.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class SwitchTabBarCell: UITableViewCell {

    private let tabBarSwitch: UISwitch
    private let tapped: (_ showTabBar: Bool) -> Void
    
    init(showTabBar: Bool, tapped: @escaping (_ showTabBar: Bool) -> Void) {
        
        tabBarSwitch = UISwitch()
        tabBarSwitch.isOn = showTabBar
        self.tapped = tapped
        
        super.init(style: .default, reuseIdentifier: type(of: self).className)
        selectionStyle = .none
        accessoryView = tabBarSwitch
        textLabel?.text = "showTabBar"
        
        tabBarSwitch.addTarget(self, action: #selector(tappedTabBarSwitch(_:)), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tappedTabBarSwitch(_ sender: UISwitch) {
        tapped(sender.isOn)
    }
}
