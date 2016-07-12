//
//  TodoModel.swift
//  TodoList
//
//  Created by Fashion on 16/7/11.
//  Copyright © 2016年 catface. All rights reserved.
//

import UIKit

// 存储数据及数据间的交互
class TodoModel: NSObject {
    
    var id, img, title: String, date: NSDate
    
    init(id: String, img: String, title: String, date: NSDate) {
        self.id = id
        self.img = img
        self.title = title
        self.date = date
    }
}

// class 存放在 heap 中(只拷贝指针)
// struct 存放在 、stack 中
