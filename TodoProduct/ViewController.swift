//
//  ViewController.swift
//  TodoProduct
//
//  Created by Keitaro Kawahara on 2022/09/05.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource {
    
    
    
    @IBOutlet var table: UITableView!
    
    let realm = try! Realm()
    var list: Results<Item>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        table.dataSource = self
        table.dataSource = self
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
     
        do{
                let realm = try Realm()
            list = realm.objects(Item.self)
            }catch{
            }
        
        table.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
            
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getdata()
        table.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Item.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! MainTableViewCell
        
        cell.titleLabel?.text = list[indexPath.row].title
        cell.dateLabel?.text = list[indexPath.row].date
        return cell
    }
    
    func getdata() {
        // Realmからデータを取得
        do{
            
            list = realm.objects(Item.self)
        }catch{
        }
        
    }
    
    
    
    
    
    
}

