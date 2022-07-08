//
//  AnswerCheckViewController.swift
//  Firebase-DiaryApp
//
//  Created by 近藤米功 on 2022/07/08.
//

// 目的：みんなの回答を表示したい
// 手順
// Answerモデルを作る
// UserNameの反映

import UIKit
import Firebase
import FirebaseFirestore

class AnswerCheckViewController: UIViewController{


    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var odaiLabel: UILabel!

    private var odaiAnswerArray: [String] = []

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "answerTableViewCell", bundle: nil), forCellReuseIdentifier: "answerTableViewID")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getOdaiText()
        getAnswerText()
    }

    private func getOdaiText(){
        let odaiDocument = db.collection("Odai").document("ubqFT0GuUxoxKxJzhhhf")
        odaiDocument.getDocument { snapShot, error in
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

    private func getAnswerText(){
        let allAnswerDB = db.collection("Answers")
        allAnswerDB.getDocuments { snapShot, error in
            if error != nil{
                return
            }
            // ドキュメントを全部所得
            if let snapShotDoc = snapShot?.documents{
                for doc in snapShotDoc{
                    let data = doc.data()
                    let answer = data["answer"] as? String
                    print("アンサー: ",answer)
                    self.odaiAnswerArray.append(answer ?? "")
                }
            }
            // ここでtableView.reloadしないと値が反映されない
            self.tableView.reloadData()
        }
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension AnswerCheckViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return odaiAnswerArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerTableViewID", for: indexPath) as! answerTableViewCell
        cell.answerLabel.text = odaiAnswerArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
