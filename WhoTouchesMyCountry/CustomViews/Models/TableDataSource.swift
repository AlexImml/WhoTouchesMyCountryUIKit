//
//  BasicCVDataSource.swift
//  WhoTouchesMyCountry
//
//  Created by Alex on 05/08/2021.
//

import UIKit

class TableDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {


    // MARK: variables
    
    private var items = [T]()
    var configureCell: (CELL,T) -> ()
    
    // MARK: init
    
    init(configureCell : @escaping (CELL, T) -> ()) {
        self.configureCell = configureCell
    }
    
    func update(items : [T]?) {
        if let items = items {
            self.items =  items
        } else {
            self.items = []
        }
    }
    
    // MARK: UITableViewDataSource funcs
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CELL.self), for: indexPath) as! CELL
        configureCell(cell,items[indexPath.row])
        
        return cell
    }
    
}
