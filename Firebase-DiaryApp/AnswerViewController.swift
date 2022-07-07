//
//  AnswerViewController.swift
//  Firebase-DiaryApp
//
//  Created by 近藤米功 on 2022/07/06.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AnswerViewController: UIViewController {

    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var answerTextView: UITextView!
    @IBOutlet private var odaiLabel: UILabel!

    var userName: String = ""

    let odaiDB = Firestore.firestore().collection("Odai").document("ubqFT0GuUxoxKxJzhhhf")

    let DB = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "nameKey") != nil{
            userName = UserDefaults.standard.object(forKey: "nameKey") as! String
        }
        userNameLabel.text = "\(userName)さんようこそ！"
        loadOdaiText()
    }

    private func loadOdaiText(){
        odaiDB.getDocument { snapShot, error in
            if error != nil{
                return
            }
            let data = snapShot?.data()
            guard let data = data else {
                return
            }
            self.odaiLabel.text = data["odaiText"] as! String
        }
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
