//
//  ViewController.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    private var idTextField: UITextField = {
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
    
    private var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색하기", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var toastView = ToastView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        bind()
    }
}
extension LoginViewController {
    private func attribute() {
        view.backgroundColor = .white
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    private func layout() {
        view.addSubviews(idTextField, checkButton)
        
        NSLayoutConstraint.activate( [idTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                      idTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                      idTextField.widthAnchor.constraint(equalToConstant: 250),
                                      idTextField.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate( [checkButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                      checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                                      checkButton.widthAnchor.constraint(equalToConstant: 80),
                                      checkButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func bind() {
        viewModel.fetchSuccess = { doodleDTO in
            DispatchQueue.main.async {
                self.showToast(message: "찾았습니다.", font: UIFont.systemFont(ofSize: 20))
            }
        }
        
        viewModel.fetchFailed = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.showToast(message: "검색결과가 없습니다.", font: UIFont.systemFont(ofSize: 20))
            }
        }
    }
    
    @objc func checkButtonTapped(sender: Any) {
        viewModel.checkButtonTapped(id: idTextField.text ?? "")
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
