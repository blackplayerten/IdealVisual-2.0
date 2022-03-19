//
//  SignInViewModel.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

protocol SignInViewModelProtocol: AnyObject {
    var bind: (() -> ()) { get set }
    func login()
}

final class SignInViewModel: SignInViewModelProtocol {

    var bind: (() -> ()) = {}

    func login() {
        
    }
}
