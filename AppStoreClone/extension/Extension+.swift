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
