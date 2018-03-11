//
//  ViewController.swift
//  BottomTableSample
//
//  Created by 須藤将史 on 2018/03/09.
//  Copyright © 2018年 須藤将史. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
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
        
        let backView = UIView()
        backView.backgroundColor = .black

        let imageView = UIImageView(image: #imageLiteral(resourceName: "apple").withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .white
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        
        let button = UIButton(type: .custom)
        button.backgroundColor = .defaultTint
        button.setTitle("Button or AD Banner", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.whiteHighlighted, for: .highlighted)
        button.addTarget(self, action: #selector(tappedBottomButton(_:)), for: .touchUpInside)
        
        let bottomFixedView = BottomFixedView(views: [button])
        
        // AutoLayout
        
        if #available(iOS 11.0, *) {
            view.addSubview(backView, constraints: [
                backView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                ])
        } else {
            let bottomInset: CGFloat = defaultContentInset.bottom + bottomFixedView.preferredHeight
            view.addSubview(backView, constraints: [
                backView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                backView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomInset)
                ])
        }
        
        view.addSubview(imageView, constraints: [
            imageView.centerXAnchor.constraint(equalTo: backView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: backView.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: backView.heightAnchor, multiplier: 0.8)
            ])
        
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
