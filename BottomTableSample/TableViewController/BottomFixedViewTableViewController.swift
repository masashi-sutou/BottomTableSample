//
//  BottomFixedViewTableViewController.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/11.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class BottomFixedViewTableViewController: UITableViewController {

    private var textA: String = ""
    private var textB: String = ""
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = type(of: self).className
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.registerCell(UITableViewCell.self)
        tableView.registerCell(TextViewCell.self)
        tableView.registerCell(TextFieldCell.self)
        
        let button = UIButton(type: .custom)
        button.backgroundColor = .defaultTint
        button.setTitle("Button or AD Banner", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.whiteHighlighted, for: .highlighted)
        button.addTarget(self, action: #selector(tappedBottomButton(_:)), for: .touchUpInside)
        
        let bottomFixedView = BottomFixedView(views: [button])
        addSubviewToBottomSafeArea(bottomFixedView, fixedHeight: bottomFixedView.preferredHeight)
    }
    
    // MARK: - Table DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let placeholder: String = "Section: " + String(indexPath.section) + " Row: " + String(indexPath.row)
        
        switch (indexPath.section, indexPath.row) {
        case (4, 0):
            let cell = TextViewCell(placeholder: placeholder, textChanged: { (text) in
                self.textA = text
            }, tappedNext: {
                if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 6)) as? TextFieldCell {
                    cell.textField.becomeFirstResponder()
                }
            })
            cell.textView.text = textA
            return cell
        case (6, 0):
            let cell = TextFieldCell(placeholder: placeholder, textChanged: { (text) in
                self.textB = text
            })
            cell.textField.text = textB
            return cell
        default:
            let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = placeholder
            cell.textLabel?.textAlignment = .center
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - Button Action
    
    @objc private func tappedBottomButton(_ sender: UIButton) {
        // "😰 I can't tap button in BottomFixedView."
    }
}
