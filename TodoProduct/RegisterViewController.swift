//
//  RegisterViewController.swift
//  TodoProduct
//
//  Created by Keitaro Kawahara on 2022/09/05.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var textView: UITextView!
    
    let realm = try! Realm()
    var list: Results<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func addButtonPressed() {
        
        
        let newTodo = Item()
        
        newTodo.title = titleTextField.text!
        newTodo.detail = textView.text!
        
       
        
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(newTodo)
            })
        }catch{
        }
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
