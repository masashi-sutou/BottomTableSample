//
//  ContainerViewController.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/10.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class ContainerViewController: UIViewController {
    
    private let transitonType: TransitonType
    
    init(transitonType: TransitonType) {
        self.transitonType = transitonType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .white
        navigationItem.title = type(of: self).className
        
        let button = UIButton(type: .custom)
        button.backgroundColor = .defaultTint
        button.setTitle("Button or AD Banner", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.whiteHighlighted, for: .highlighted)
        button.addTarget(self, action: #selector(tappedBottomButton(_:)), for: .touchUpInside)
        
        let bottomFixedView = BottomFixedView(views: [button])
        
        let childViewController = TableViewController()

        if #available(iOS 11.0, *) {
        } else {
            var inset: UIEdgeInsets = defaultContentInset
            switch transitonType {
            case .push:
                inset.top = -statusBarHeight
            case .present:
                inset.top = 0
            }
            inset.bottom += bottomFixedView.preferredHeight
            childViewController.tableView.contentInset = inset
            childViewController.tableView.scrollIndicatorInsets = inset
        }

        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
        
        addSubviewToBottomSafeArea(bottomFixedView, fixedHeight: bottomFixedView.preferredHeight)
    }
        
    // MARK: - Button Action
    
    @objc private func tappedBottomButton(_ sender: UIButton) {
        switch transitonType {
        case .push:
            navigationController?.popViewController(animated: true)
        case .present:
            dismiss(animated: true, completion: nil)
        }
    }
}
