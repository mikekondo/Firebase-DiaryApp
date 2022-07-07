//
//  AnswerViewController.swift
//  Firebase-DiaryApp
//
//  Created by 近藤米功 on 2022/07/06.
//

// UserDefalutsにAnswersのドキュメントパスを保存
// Answersにはユーザ名、answerTextView、日付を保存する

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import PKHUD

class AnswerViewController: UIViewController {

    @IBOutlet private var userNameLabel: UILabel!
    @IBOutlet private var answerTextView: UITextView!
    @IBOutlet private var odaiLabel: UILabel!

    var userName: String = ""

    let odaiDB = Firestore.firestore().collection("Odai").document("ubqFT0GuUxoxKxJzhhhf")

    let DB = Firestore.firestore()

    private var answersPath: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "nameKey") != nil {
            userName = UserDefaults.standard.object(forKey: "nameKey") as! String
        }
        answersPath = DB.collection("Answers").document().path
        answersPath = String(answersPath.dropFirst(8))
        print("answerPath:",answersPath)
        userNameLabel.text = "\(userName)さんようこそ！"
        loadOdaiText()
    }

    @IBAction func didTapAnswerSendButton(_ sender: Any) {
        sendAnswerTextView()
        HUD.flash(.success, delay: 1)
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

    private func loadOdaiText(){
        odaiDB.getDocument { snapShot, error in
            if error != nil{
                return
            }
            let data = snapShot?.data()
            guard let data = data else {
                return
            }
            self.odaiLabel.text = data["odaiText"] as? String
        }
    }

    private func sendAnswerTextView(){
        let answerText = answerTextView.text ?? ""
        DB.collection("Answers").document(answersPath).setData(["answer" : answerText,"userName": userName,"postDate":Date().timeIntervalSince1970])
        answerTextView.text = ""
    }

}
