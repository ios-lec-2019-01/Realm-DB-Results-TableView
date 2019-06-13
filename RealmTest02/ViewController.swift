//
//  ViewController.swift
//  RealmTest02
//
//  Created by 김종현 on 30/05/2019.
//  Copyright © 2019 김종현. All rights reserved.
//

import UIKit
import RealmSwift

// 데이터베이스 모델
class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
}

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var resultTableView: UITableView!
    
    // auto-updating container type in Realm returned from object queries.
    // Results는 실시간으로 기본 데이터가 자동으로 뷰에 업데잍, 됨. 이는 Results가 다시 불러올 필요가 없다는 것을 말함
    var personArray : Results<Person>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.dataSource = self
        
        // 프로그램 실행 초기에 데이터 불러오기
        let realm = try! Realm()
        personArray = realm.objects(Person.self)
        
        self.title = "Realm DB Test"
        
        // 데이터가 실제 저장된 디스크 위치 출력(Realm Broswer에서 사용) .../Documents/...
        print(NSHomeDirectory())
        
    }
    
    @IBAction func addObject(_ sender: Any) {
        // 새객체생성
        let newPerson = Person()
        newPerson.name = nameTextField.text!
        newPerson.age = Int(ageTextField.text!)!
        
        // DB에 저장
        let realm = try! Realm()
        try! realm.write {
            realm.add(newPerson)
        }
        nameTextField.text = ""
        ageTextField.text = ""
        
        // TableView의 데이터를 새로 갱신
        resultTableView.reloadData()
    }
    
    @IBAction func getObject(_ sender: Any) {
        let realm = try! Realm()
        personArray = realm.objects(Person.self).filter("age > 10")
        print(personArray!)
        
        // TableView의 데이터를 새로 갱신
        resultTableView.reloadData()

    }
    
    @IBAction func deleteObject(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        // TableView의 데이터를 새로 갱신
        resultTableView.reloadData()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultTableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        cell.textLabel?.text = personArray![indexPath.row].name
        cell.detailTextLabel?.text = String(personArray![indexPath.row].age)
        return cell
    }
    
    // cell delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            try! realm.write {
                realm.delete(personArray![indexPath.row])
            }
            // 데이터 업데이트
            personArray = realm.objects(Person.self)
            self.resultTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = resultTableView.indexPath(for: cell) {
            let target = personArray![indexPath.row]
            
            if let vc = segue.destination as? DetailViewController {
                vc.name = target.name
                vc.age = target.age
                
            }
        }
    }
}

