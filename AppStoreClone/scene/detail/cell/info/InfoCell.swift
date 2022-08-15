//
//  InfoCell.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/13.
//

import UIKit

final class InfoCell: UICollectionViewCell {
    static let id = String(describing: InfoCell.self)
    static let cellCount = 5
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정보"
        label.textColor = .systemGray4
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "greaterthan"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let dividerLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private var contentConstraints = [NSLayoutConstraint]()
    private var contentsConstraints = [NSLayoutConstraint]()
    private var moreButtonConstraints = [NSLayoutConstraint]()
    private var titleConstraints = [NSLayoutConstraint]()
    private var expendAction: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        bind()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        contentLabel.text = nil
        
        addSubview(moreButton)
        //moreButton.removeConstraints(moreButtonConstraints)
    }
}
extension InfoCell {
    private func layout() {
        addSubviews(titleLabel, contentLabel, moreButton, dividerLine)
        contentConstraints = [contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                              contentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                              contentLabel.widthAnchor.constraint(equalToConstant: 250),
                              contentLabel.heightAnchor.constraint(equalToConstant: 30)]
        
        contentsConstraints = [contentLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -5),
                               contentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                               contentLabel.widthAnchor.constraint(equalToConstant: 250),
                               contentLabel.heightAnchor.constraint(equalToConstant: 30)]
        
        moreButtonConstraints = [moreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                                 moreButton.centerYAnchor.constraint(equalTo: self.contentLabel.centerYAnchor),
                                 moreButton.widthAnchor.constraint(equalToConstant: 20),
                                 moreButton.heightAnchor.constraint(equalToConstant: 20)]
        
        titleConstraints = [titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                            titleLabel.widthAnchor.constraint(equalToConstant: 80),
                            titleLabel.heightAnchor.constraint(equalToConstant: 30)]
        
        NSLayoutConstraint.activate(titleConstraints)
        NSLayoutConstraint.activate( [dividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0.5),
                                      dividerLine.widthAnchor.constraint(equalTo: self.widthAnchor),
                                      dividerLine.heightAnchor.constraint(equalToConstant: 0.5),
                                      dividerLine.leadingAnchor.constraint(equalTo: self.leadingAnchor)])
    }
    
    private func bind() {
        moreButton.addTarget(self, action: #selector(moreButtonAction), for: .touchUpInside)
    }
    
    @objc func moreButtonAction(sender: Any) {
        expendAction?()
        setExpendLayout()
    }
    
    func configuration(title titleText: String, contents contentsText: String?) {
        titleLabel.text = titleText
        contentLabel.text = contentsText
        setContentLayout()
    }
    
    func configuration(title titleText: String, contents contentsText: String, expend: Bool, expendAction: (() -> ())?) {
        titleLabel.text = titleText
        contentLabel.text = contentsText
        self.expendAction = expendAction
        
        expend ? setExpendLayout() : setContentsLayout()
    }
    
    private func setContentLayout() {
        moreButton.isHidden = true
        NSLayoutConstraint.activate(contentConstraints)
        self.layoutIfNeeded()
    }
    
    private func setContentsLayout() {
        moreButton.isHidden = false
        NSLayoutConstraint.activate(self.moreButtonConstraints)
        NSLayoutConstraint.activate(self.contentsConstraints)
        self.layoutIfNeeded()
        
        
    }
    
    private func setExpendLayout() {
        contentLabel.numberOfLines = 0
        moreButton.removeConstraints(moreButtonConstraints)
        moreButton.removeFromSuperview()
        contentLabel.font = UIFont.systemFont(ofSize: 14)
        UIView.animate(withDuration: 0.2) {
            self.contentLabel.removeConstraints(self.contentsConstraints)
            self.contentLabel.removeConstraints(self.contentConstraints)
            let expendContentsConstraints = [self.contentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
                                             self.contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
                                             self.contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                                             self.contentLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)]
            NSLayoutConstraint.activate(expendContentsConstraints)
        }
        self.layoutIfNeeded()
    }
}
