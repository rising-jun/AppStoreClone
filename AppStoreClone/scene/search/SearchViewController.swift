//
//  ViewController.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        bind()
    }
}
extension SearchViewController {
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
        viewModel.fetchSuccess = { [weak self] doodleDTO in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let detailViewController = DetailViewController()
                guard let detailDTO = doodleDTO.results.first else { return }
                detailViewController.viewModel.setDetailDTO(detailDTO)
                detailViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
        
        viewModel.fetchFailed = {
            DispatchQueue.main.async {
                self.showToast(message: "검색결과가 없습니다.", font: UIFont.systemFont(ofSize: 20))
            }
        }
    }
    
    @objc func checkButtonTapped(sender: Any) {
        //viewModel.checkButtonTapped(id: idTextField.text ?? "")
        viewModel.checkButtonTapped(id: "872469884")
    }
}
