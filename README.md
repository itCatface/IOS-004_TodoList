# 日期

- **格式化日期方法**

		func dateFromString(dateStr: String) -> NSDate? {
		    
		    let dateFormatter = NSDateFormatter()
		    dateFormatter.dateFormat = "yyyy-MM-dd"
		    return dateFormatter.dateFromString(dateStr)
		}
		
- **国际化格式日期**

		// 国际化日期模板
		let locale = NSLocale.currentLocale()
		let dateFormatterTemplate = NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
		
		// 日期格式
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = dateFormatterTemplate
		
		date?.text = dateFormatter.stringFromDate(todo.date)
		
# 创建本地临时数据库

- **在类外定义**

		// bean 对象数组
		var todos: [TodoModel] = []
		
# TableView

- **接口**

	- **UITableViewDataSource**：数据源

			// TableView 行数
			public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	
		---
			// 相当于 Android 的 BaseAdapter 中的 getView() 方法
			public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
		
	- **UITableViewDelegate**

			// 手势-编辑删除 TableView 某行功能
			// 按钮-可配合横线下面方法
		    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		        
		        if editingStyle == UITableViewCellEditingStyle.Delete {
		            todos.removeAtIndex(indexPath.row)
		            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
		        }
		    }
		    
		---
		
			// 添加功能
		    override func setEditing(editing: Bool, animated: Bool) {
		        super.setEditing(editing, animated: animated)
		        self.tableView.setEditing(editing, animated: animated)
		    }
		    
	- **TableView 删除行后重新加载数据**

			tableView.reloadData()
			
	- **点击编辑时跳转 ViewController 并将当前选中行信息传递**

		    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		        if segue.identifier == "TodoEditor" {
		            
		            var vc = segue.destinationViewController as? DetailViewController
		            var  indexPath = tableView.indexPathForSelectedRow
		        
		            if let index = indexPath {
		                vc!.todoItem = todos[index.row]
		            }
		        }
		    }
		    
	- **脚踏板移动行功能**

		    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
	        	return editing
		    }
		    
		    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
		        let todo = todos.removeAtIndex(sourceIndexPath.row)
		        
		        todos.insert(todo, atIndex: destinationIndexPath.row)
		    }
		    
# 搜索

- **接口**

		UISearchDisplayDelegate
		
- **隐藏搜索栏**

        var contentOffset = tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
        
 - **搜索**

			func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
				filterTodos = todos.filter() {
					// 过滤搜索条件
				    $0.title.rangeOfString(searchString) != nil
				}
				return true
			}
			    
			func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
			    // 行高
			    return 80
			}
