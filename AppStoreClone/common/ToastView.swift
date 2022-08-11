//
//  ToastView.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class ToastView: UIView {
    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        attribute()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
extension ToastView {
    private func layout() {
        backgroundColor = .black
    }
    
    private func attribute() {
        addSubview(noticeLabel)
        NSLayoutConstraint.activate([noticeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                                     noticeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    
    func setText(_ message: String) {
        noticeLabel.text = message
    }
}
