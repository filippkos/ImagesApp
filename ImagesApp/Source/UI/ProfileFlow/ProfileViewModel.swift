//
//  ProfileViewController.swift
//  ImagesApp
//
//  Created by Filipp Kosenko on 07.02.2025.
//

import UIKit
import FirebaseAuth

enum ProfileViewModelOutputEvent: ViewModelEvent {
    case logout
}

final class ProfileViewModel: BaseViewModel<ProfileViewModelOutputEvent> {
    
    func user() -> (String, String) {
        if let user = Auth.auth().currentUser {
            return (user.email ?? "", user.uid)
        }
        return ("","")
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            self.outputEvents?(.logout)
        } catch {
            
        }
    }
}
