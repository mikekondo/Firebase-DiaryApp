//
//  AnswerViewController.swift
//  Firebase-DiaryApp
//
//  Created by 近藤米功 on 2022/07/06.
//

import UIKit
import Firebase
import FirebaseAuth

class AnswerViewController: UIViewController {

    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var answerTextView: UITextView!

    var userName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "nameKey") != nil{
            userName = UserDefaults.standard.object(forKey: "nameKey") as! String
        }
        userNameLabel.text = "\(userName)さんようこそ！"
    }

    @IBAction func didTapLogoutButton(_ sender: Any) {
        logout()
        dismiss(animated: true)
    }

    private func logout(){
        do {
            try Auth.auth().signOut()
        }
        catch let error as NSError{
            print(error)
        }
    }

}
