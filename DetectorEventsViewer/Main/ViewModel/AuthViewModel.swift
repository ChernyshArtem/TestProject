//
//  AuthViewModel.swift
//  DetectorEventsViewer
//
//  Created by Артём Черныш on 13.12.23.
//

import Foundation

protocol AuthViewModelInterface {
    func checkUserLogin(name: String, password: String, completion: @escaping (_ success: Bool) -> ())
}

class AuthViewModel: AuthViewModelInterface {
    
    private let apiWorker = APIWorker()
    
    init() {
    }
    
    func checkUserLogin(name: String, password: String, completion: @escaping (_ success: Bool) -> ()) {
        apiWorker.checkUserLogin(name: name, password: password) { success in
            if success {
                UserDefaults.standard.set(name, forKey: "name")
            }
            completion(success)
        }
    }
    
}
