//
//  Extension+.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension String {
    var numberOfLines: Int {
        return self.components(separatedBy: "\n").count
    }
}

extension UIViewController {
    func showToast(message : String, font: UIFont) {
        let toastLabel: UILabel = {
            let label = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: view.frame.size.width - 100, height: 35))
            label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            label.textColor = UIColor.white
            label.font = font
            label.textAlignment = .center
            label.text = message
            label.alpha = 1.0
            label.layer.cornerRadius = 10
            label.clipsToBounds  =  true
            label.adjustsFontSizeToFitWidth = true
            return label
        }()
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
