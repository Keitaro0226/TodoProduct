//
//  ViewController.swift
//  TodoProduct
//
//  Created by Keitaro Kawahara on 2022/09/05.
//

import UIKit
import RealmSwift
import SwiftUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet var table: UITableView!
    
    let realm = try! Realm()
    var list: Results<Item>!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        table.dataSource = self
        table.delegate = self
        
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
    
    // セルがタップされた時の処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = self.table.cellForRow(at:indexPath) as! MainTableViewCell
        
        print(list[indexPath.row])
        
        let nextView = storyboard!.instantiateViewController(withIdentifier: "secondMain") as! RegisterViewController//遷移先のViewControllerを設定
        
        nextView.listTitle = list[indexPath.row].title
        nextView.listDetail = list[indexPath.row].detail
        nextView.listDate = list[indexPath.row].date
        self.navigationController?.pushViewController(nextView, animated: true)
        
    }
    
    // スワイプした時に表示するアクションの定義
      func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

       // 削除処理
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
          //削除処理を記述
           
            let realm = try! Realm()
           
            do{
              try realm.write{
                  realm.delete(self.list[indexPath.row])
              }
            }catch {
              print("Error \(error)")
            }
            
          print("Deleteがタップされた")
            self.table.reloadData()

          // 実行結果に関わらず記述
          completionHandler(true)
        }

        // 定義したアクションをセット
        return UISwipeActionsConfiguration(actions: [deleteAction])
      }
    

    
    
    
    
    func getdata() {
        // Realmからデータを取得
        do{
            
            list = realm.objects(Item.self)
        }catch{
        }
        
    }
    
    





}

