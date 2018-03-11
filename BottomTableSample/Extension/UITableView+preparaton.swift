//
//  UITableView+preparaton.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/10.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

extension NSObjectProtocol {
    static var className: String {
        return String(describing: Self.self)
    }
}

extension UITableView {
    
    func registerCell<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType, forCellReuseIdentifier: cellType.className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
}
