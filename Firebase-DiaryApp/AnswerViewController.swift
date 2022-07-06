//
//  AnswerViewController.swift
//  Firebase-DiaryApp
//
//  Created by 近藤米功 on 2022/07/06.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!

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
}
