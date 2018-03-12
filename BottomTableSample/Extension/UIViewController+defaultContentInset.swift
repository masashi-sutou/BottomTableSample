//
//  UIViewController+defaultContentInset.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/09.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

extension UIViewController {
    
    final func addSubviewToBottomSafeArea(_ bottomFixedView: UIView, fixedHeight: CGFloat) {
        
        if #available(iOS 11.0, *) {
            additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: fixedHeight, right: 0)
            view.addSubview(bottomFixedView, constraints: [
                bottomFixedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                bottomFixedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomFixedView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                ])
            
            if tabBarController?.tabBar.isHidden ?? true {
                bottomFixedView.bottomAnchor.constraint(equalTo: view.bottomAnchor).activate()
            } else {
                bottomFixedView.heightAnchor.constraint(equalToConstant: fixedHeight).activate()
            }
        } else {
            view.addSubview(bottomFixedView, constraints: [
                bottomFixedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomFixedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomFixedView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor),
                bottomFixedView.heightAnchor.constraint(equalToConstant: fixedHeight)
                ])
        }
    }
    
    var defaultContentInset: UIEdgeInsets {
        return UIEdgeInsets(top: statusBarHeight + navigationBarHeight, left: 0, bottom: tabBarHeight, right: 0)
    }
    
    var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    private var navigationBarHeight: CGFloat {
        guard let nav = navigationController else { return 0 }
        return nav.isNavigationBarHidden ? 0 : nav.navigationBar.frame.height
    }
    
    private var tabBarHeight: CGFloat {
        guard let tab = tabBarController else { return 0 }
        return tab.tabBar.isHidden ? 0 : tab.tabBar.frame.height
    }
}
