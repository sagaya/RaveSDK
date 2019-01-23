//
//  SnackBar.swift
//  GetBarter
//
//  Created by Sagaya Abdulhafeez on 07/01/2019.
//  Copyright © 2019 Olusegun Solaja. All rights reserved.
//

import UIKit

class SnackBar: UIView {
    lazy var typeIndicator: UIView = {
        let v = UIView()
        return v
    }()
    
    lazy var statusMessage: UILabel = {
        let lab = UILabel()
        lab.textColor = .darkGray
        lab.font = UIFont(name: "AvenirNext-Regular", size: 13)
        lab.numberOfLines = 0
        return lab
    }()
    var message:String?{
        didSet{
            statusMessage.text = message
        }
    }
    var statusColor: UIColor?{
        didSet{
            typeIndicator.backgroundColor = statusColor
        }
    }
    lazy var okButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Okay", for: .normal)
        btn.titleLabel!.font = UIFont(name: "AvenirNext-Bold", size: 13)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.addTarget(self, action: #selector(hideSnack), for: .touchUpInside)
        return btn
    }()
    static var shared = SnackBar()
    let currentWindow = UIApplication.shared.keyWindow
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.layer.applySketchShadow(color: UIColor(hex: "#000000"), alpha: 0.5, x: 0, y: 2, blur: 30, spread: -10)
        addSubview(typeIndicator)
        typeIndicator.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, size: .init(width: 8, height: frame.height))
        addSubview(statusMessage)
        statusMessage.anchor(top: topAnchor, leading: typeIndicator.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 70))
        addSubview(okButton)
        okButton.anchor(top: topAnchor, leading: statusMessage.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
    }
    var viewBottomAnchor:NSLayoutConstraint?
    @objc func hideSnack(){
        UIView.animate(withDuration: 1.5, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [.curveEaseInOut], animations: {
            self.viewBottomAnchor?.constant = 0
            self.layoutIfNeeded()
        }, completion: {(_) in
            self.removeFromSuperview()
        })
    }
    func show(){
        guard let window = UIApplication.shared.keyWindow else {return}
        window.addSubview(self)
        window.bringSubviewToFront(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.viewBottomAnchor = self.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 80)
        self.viewBottomAnchor?.isActive = true
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: window.leadingAnchor, constant: 20),
            self.trailingAnchor.constraint(equalTo: window.trailingAnchor, constant: -20),
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIWindow.animate(withDuration: 10, animations: {
                self.viewBottomAnchor?.constant = -60
                self.layoutIfNeeded()
            }, completion: {(_) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
                    UIWindow.animate(withDuration: 1.5, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [.curveEaseInOut], animations: {
                        self.viewBottomAnchor?.constant = 0
                        self.layoutIfNeeded()
                    }, completion: {(_) in
                        self.removeFromSuperview()
                    })
                })
            })
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
