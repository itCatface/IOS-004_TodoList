//
//  ViewController.swift
//  Todo
//
//  Created by Fashion on 16/7/11.
//  Copyright © 2016年 catface. All rights reserved.
//
/*
 
 1. 创建本地运行时数据库
 2. 绑定数据 Model 到 View 中
 3. 删除：a手势左滑b添加edit编辑按钮
 
 
 */

import UIKit

// 创建本地运行时数据库
var todos: [TodoModel] = []

// 格式化日期
func dateFromString(dateStr: String) -> NSDate? {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.dateFromString(dateStr)
    
}

// Search
var filterTodos: [TodoModel] = []

// UITableViewDataSource 接口(数据源)
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        todos = [TodoModel(id: "1", img: "child_selected", title: "1111", date: dateFromString("2016-09-11")!),
                 TodoModel(id: "2", img: "calling_selected", title: "2222", date: dateFromString("2016-09-12")!),
                 TodoModel(id: "3", img: "shopping_selected", title: "3333", date: dateFromString("2016-09-13")!),
                 TodoModel(id: "4", img: "plane_selected", title: "4444", date: dateFromString("2016-09-14")!)]
        
        print(dateFromString("2015-05-05")!)
        
        
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        
        // 隐藏搜索栏
        var contentOffset = tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // -MARK- UITableViewDataSource
    // -MARK- Search
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController?.searchResultsTableView {
            return filterTodos.count
        } else {
            return todos.count
        }
        
        
    }
    
   
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell", forIndexPath: indexPath) as UITableViewCell
        
        var todo: TodoModel
        
        
        if tableView == searchDisplayController?.searchResultsTableView {
            todo = filterTodos[indexPath.row] as TodoModel
        } else {
            todo = todos[indexPath.row] as TodoModel
        }
        
        
        
        var img = cell.viewWithTag(100) as? UIImageView
        var title = cell.viewWithTag(1) as? UILabel
        var date = cell.viewWithTag(2) as? UILabel
        
        img?.image = UIImage(named: todo.img)
        
        title?.text = todo.title
        
        
        // 时间格式国际化
        let locale = NSLocale.currentLocale()
        let dateFormatterTemplate = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormatterTemplate
        
        date?.text = dateFormatter.stringFromDate(todo.date)
        
        return cell
    }
    
    
    // -MARK- UITableViewDelegate
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todos.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    // -MARK- EditMore
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    
    // -MARK- 返回
    @IBAction func close(segue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
    
    
   
    // -MARK- 编辑
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TodoEditor" {
            
            
            var vc = segue.destinationViewController as? DetailViewController
            var  indexPath = tableView.indexPathForSelectedRow
        
            if let index = indexPath {
                vc!.todoItem = todos[index.row]
            }
        }
    }
    
    // -MARK- Move Cell
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo = todos.removeAtIndex(sourceIndexPath.row)
        
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    
    // -MARK- Search
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        filterTodos = todos.filter() {
            $0.title.rangeOfString(searchString) != nil
        }
        return true
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

}

