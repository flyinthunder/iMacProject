//
//  ReviewViewController.swift
//  TravelMaster
//
//  Created by Admin on 07/06/19.
//  Copyright © 2019 Imac. All rights reserved.
//

import UIKit
import SQLite3

class ReviewViewController: UIViewController {
    var data: [review] = []
    @IBOutlet weak var tableView: UITableView!
    
    func loaddata() -> [review] {
            
        var tempdata: [review] = []
            
            //this is our select query
        let queryString = "SELECT * FROM review"
            
            //statement pointer
        var stmt:OpaquePointer?
            
            //preparing the query
            if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing insert: \(errmsg)")
            }
            
            //traversing through all the records
            while(sqlite3_step(stmt) == SQLITE_ROW){
                let id = sqlite3_column_int(stmt, 1)
                print(id)
                print(identificationnum)
                if Int(id) == identificationnum {
                let star = String(cString: sqlite3_column_text(stmt, 2))
                print(star)
                    let starint:Int = Int(star) ?? 0
                let description = String(cString:sqlite3_column_text(stmt, 3))
                print(description)
                
                
                    let dataelement = review(star: 0, title: "", review: description)
                    
                    tempdata.append(dataelement)
                }
                
            }
            
            return tempdata
            
        }
        
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       data = loaddata()
       tableView.delegate = self
       tableView.dataSource = self
        
    }
    

}


extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celldata = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as! ReviewCell
        
        cell.setdata(dataelement: celldata)
        return cell
    }
    
    
    
    
}
