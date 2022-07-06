//
//  LoginViewController.swift
//  Firebase-DiaryApp
//
//  Created by 近藤米功 on 2022/07/06.
//

import UIKit
import FirebaseAuth
import Firebase

final class LoginViewController: UIViewController {

    @IBOutlet var nameTextFiled: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func login(){
        let name = nameTextFiled.text ?? ""
        UserDefaults.standard.set(name, forKey: "nameKey")
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            print("userのuid",user.uid)
        }
        performSegue(withIdentifier: "answerSegue", sender: nil)
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        login()
    }


}
