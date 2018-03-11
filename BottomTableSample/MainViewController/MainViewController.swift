//
//  MainViewController.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/09.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private var viewTransitonType: TransitonType = .push
    private var containerTransitonType: TransitonType = .push
    private var showTabBarInView: Bool = false
    private var showTabBarInTable: Bool = false
    private var showTabBarInContainer: Bool = false
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.title = type(of: self).className
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = SwitchTabBarCell(showTabBar: showTabBarInView, tapped: { (showTabBar) in
                    self.showTabBarInView = showTabBar
                })
                return cell
            } else if indexPath.row == 1 {
                let cell = TransitonTypeCell(type: viewTransitonType, tapped: { (selectedTransitonType) in
                    self.viewTransitonType = selectedTransitonType
                })
                return cell
            } else {
                cell.textLabel?.text = "😀 Show BottomFixedView"
                cell.detailTextLabel?.text = ViewController.className
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "😃 Automatically adjust keyboard height"
                cell.detailTextLabel?.text = TableViewController.className
            } else if indexPath.row == 1 {
                let cell = SwitchTabBarCell(showTabBar: showTabBarInTable, tapped: { (showTabBar) in
                    self.showTabBarInTable = showTabBar
                })
                return cell
            } else {
                cell.textLabel?.text = "😰 I can't show BottomFixedView"
                cell.detailTextLabel?.text = BottomFixedViewTableViewController.className
            }
        }
        
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                let cell = SwitchTabBarCell(showTabBar: showTabBarInContainer, tapped: { (showTabBar) in
                    self.showTabBarInContainer = showTabBar
                })
                return cell
            } else if indexPath.row == 1 {
                let cell = TransitonTypeCell(type: containerTransitonType, tapped: { (selectedTransitonType) in
                    self.containerTransitonType = selectedTransitonType
                })
                return cell
            } else {
                cell.textLabel?.text = "😊 Show BottomFixedView and automatically adjust keyboard height"
                cell.detailTextLabel?.text = ContainerViewController.className
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 2 {
            let next = ViewController(transitonType: viewTransitonType)
            switch viewTransitonType {
            case .push:
                guard showTabBarInView else {
                    navigationController?.pushViewController(next, animated: true)
                    return
                }
                
                next.tabBarItem = UITabBarItem(title: ViewController.className, image: #imageLiteral(resourceName: "small_apple"), tag: 0)
                let tab = UITabBarController()
                tab.navigationItem.title = UITabBarController.className
                tab.setViewControllers([next], animated: false)
                navigationController?.pushViewController(tab, animated: true)
                
            case .present:
                guard showTabBarInView else {
                    present(next, animated: true, completion: nil)
                    return
                }
                                
                next.tabBarItem = UITabBarItem(title: ViewController.className, image: #imageLiteral(resourceName: "small_apple"), tag: 0)
                let tab = UITabBarController()
                tab.navigationItem.title = UITabBarController.className
                tab.setViewControllers([next], animated: false)
                present(tab, animated: true, completion: nil)
            }
        }
        
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                let next = TableViewController()
                navigationController?.pushViewController(next, animated: true)

            } else if indexPath.row == 2 {
                let next = BottomFixedViewTableViewController()
                guard showTabBarInTable else {
                    navigationController?.pushViewController(next, animated: true)
                    return
                }
                
                next.tabBarItem = UITabBarItem(title: BottomFixedViewTableViewController.className, image: #imageLiteral(resourceName: "small_apple"), tag: 0)
                let tab = UITabBarController()
                tab.navigationItem.title = UITabBarController.className
                tab.setViewControllers([next], animated: false)
                navigationController?.pushViewController(tab, animated: true)
            }
        }
        if indexPath.section == 2 && indexPath.row == 2 {
            let next = ContainerViewController(transitonType: containerTransitonType)
            switch containerTransitonType {
            case .push:
                guard showTabBarInContainer else {
                    navigationController?.pushViewController(next, animated: true)
                    return
                }
                
                next.tabBarItem = UITabBarItem(title: ContainerViewController.className, image: #imageLiteral(resourceName: "small_apple"), tag: 0)
                let tab = UITabBarController()
                tab.navigationItem.title = UITabBarController.className
                tab.setViewControllers([next], animated: false)
                navigationController?.pushViewController(tab, animated: true)
                
            case .present:
                guard showTabBarInContainer else {
                    present(next, animated: true, completion: nil)
                    return
                }

                next.tabBarItem = UITabBarItem(title: ContainerViewController.className, image: #imageLiteral(resourceName: "small_apple"), tag: 0)
                let tab = UITabBarController()
                tab.navigationItem.title = UITabBarController.className
                tab.setViewControllers([next], animated: false)
                present(tab, animated: true, completion: nil)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
