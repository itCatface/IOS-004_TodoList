//
//  DetailViewController.swift
//  Todo
//
//  Created by Fashion on 16/7/11.
//  Copyright © 2016年 catface. All rights reserved.
//

import UIKit

// 键盘

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btCall: UIButton!
    @IBOutlet weak var btChild: UIButton!
    @IBOutlet weak var btPlane: UIButton!
    @IBOutlet weak var btShopping: UIButton!
    
    @IBOutlet weak var todoStr: UITextField!
    
    @IBOutlet weak var todoPicker: UIDatePicker!
    
    
    
    var todoItem: TodoModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        todoStr.delegate = self
        
        
        if todoItem == nil {
            btCall.selected = true
            navigationController?.title = "New Item"
        } else {
            navigationController?.title = "Update"
            if todoItem?.img == "calling_selected" {
                btCall.selected = true
            } else if todoItem?.img == "child_selected" {
                btChild.selected = true
            } else if todoItem?.img == "plane_selected" {
                btPlane.selected = true
            } else if todoItem?.img == "shopping_selected" {
                btShopping.selected = true
            }
        }
        
        if let todo = todoItem?.title {
            todoStr.text = todo
        }
        
        if let date = todoItem?.date {
            todoPicker.setDate((todoItem?.date)!, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func resetBt() {
        btCall.selected = false
        btChild.selected = false
        btPlane.selected = false
        btShopping.selected = false
    }
    
    @IBAction func call(sender: AnyObject) {
        resetBt()
        btCall.selected = true
        
        print(btCall.selected)
    }

    
    @IBAction func child(sender: AnyObject) {
        resetBt()
        btChild.selected = true
        print(btCall.selected)
        
    }

    @IBAction func plane(sender: AnyObject) {
        resetBt()
        btPlane.selected = true
    }
    
    @IBAction func shopping(sender: AnyObject) {
        resetBt()
        btShopping.selected = true
    }
    
    @IBAction func btOk(sender: AnyObject) {
        
        
        var img = ""
        if btCall.selected {
            img = "calling_selected"
        } else if btChild.selected {
            img = "child_selected"
        } else if btPlane.selected {
            img = "plane_selected"
        } else if btShopping.selected {
            img = "shopping_selected"
        }
        
        if todoItem == nil {
        
            let uuid = NSUUID().UUIDString
            var todo = TodoModel(id: uuid, img: img, title: todoStr.text!, date: todoPicker.date)
            
            todos.append(todo)
        } else {
            todoItem?.img = img
            todoItem?.title = todoStr.text!
            todoItem?.date = todoPicker.date
        }
    
    }
    
    
    
    
    // -MARK- 键盘
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 点击去焦点
        textField.resignFirstResponder()
        return true
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        todoStr.resignFirstResponder()
    }
    
  
}
