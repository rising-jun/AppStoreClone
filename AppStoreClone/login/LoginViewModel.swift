//
//  LoginViewModel.swift
//  AppStoreClone
//
//  Created by 김동준 on 2022/08/11.
//

import Foundation

final class LoginViewModel {
    var state = LoginViewState()
    
}
extension LoginViewModel {
    func checkButtonTapped(id: String) {
        print(id)
    }
}
struct LoginViewState {
    var loginResult: Bool = false
}
