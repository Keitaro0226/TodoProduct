//
//  RegisterViewController.swift
//  TodoProduct
//
//  Created by Keitaro Kawahara on 2022/09/05.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var toolBar:UIToolbar!
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var textView: UITextView!
    
    @IBOutlet var datePickerTextField: UITextField!
    
    let realm = try! Realm()
    let datePicker = UIDatePicker()
    var list: Results<Item>!
    
    var listTitle: String?
    var listDetail: String?
    var listDate: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        datePickerTextField.delegate = self
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.preferredDatePickerStyle = .wheels
        setupToolbar()
    
        setupToolbar()
    
        guard let listTitle = listTitle else {return}
        titleTextField.text = listTitle
       
        
        
        guard let listDate = listDate else {return}
        datePickerTextField.text = listDate
        
        guard let listDetail = listDetail else {return}
        textView.text = listDetail
        
        
    }
    
    
    @IBAction func addButtonPressed() {
        
        
        let newTodo = Item()
        
        newTodo.title = titleTextField.text!
        newTodo.detail = textView.text!
        newTodo.date = datePickerTextField.text!
        
        
        
        
        
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                
                realm.add(newTodo)
            })
        }catch{
        }
    }
    
    func setupToolbar() {
        //datepicker上のtoolbarのdoneボタン
        toolBar = UIToolbar()
        toolBar.sizeToFit()
        let toolBarBtn = UIBarButtonItem(title: "DONE", style: .plain, target: self, action: #selector(doneBtn))
        toolBar.items = [toolBarBtn]
        datePickerTextField.inputAccessoryView = toolBar
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        textField.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
    }
    
    //datepickerが選択されたらtextfieldに表示
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        datePickerTextField.text = (formatter.string(from: Date()))
    }
    
    //toolbarのdoneボタン
    @objc func doneBtn(){
        datePickerTextField.resignFirstResponder()
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
