//
//  DetailViewController.swift
//  RealmTest02
//
//  Created by 김종현 on 09/06/2019.
//  Copyright © 2019 김종현. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var name: String?
    var age: Int?
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        ageLabel.text = String(age!)
//        print(name)
//        print(age)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
