//
//  SignUpViewModel.swift
//  IdealVisual
//
//  Created by Sasha Kurganova on 27.11.2021.
//

protocol SignUpViewModelProtocol: AnyObject {
    var bind: (() -> ()) { get set }
    func signup()
}

final class SignUpViewModel: SignUpViewModelProtocol {

    var bind: (() -> ()) = {}

    func signup() {
        
    }
}
