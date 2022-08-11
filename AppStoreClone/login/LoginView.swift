//
//  LoginView.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class LoginView: UIView {
    
    var idTextField: UITextField = {
        let textField = UITextField()
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "id를 입력하세요",
            attributes: [.paragraphStyle: centeredParagraphStyle]
        )
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray5
        return textField
    }()
    
    var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색하기", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func attribute() {
        backgroundColor = .white
    }
    
    private func layout() {
        addSubviews(idTextField, checkButton)
        
        NSLayoutConstraint.activate( [idTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                                      idTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                      idTextField.widthAnchor.constraint(equalToConstant: 250),
                                      idTextField.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate( [checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                                      checkButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                                      checkButton.widthAnchor.constraint(equalToConstant: 80),
                                      checkButton.heightAnchor.constraint(equalToConstant: 50)])
    }
}

