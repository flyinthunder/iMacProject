//
//  Places.swift
//  travelguide
//
//  Created by Admin on 06/06/19.
//  Copyright © 2019 Imac. All rights reserved.
//

import UIKit
import SQLite3
var identificationnum: Int = 0
let defimage = URL(string: "https://cdn.wallpaper.com/main/styles/responsive_1680w_scale/s3/blossom-dreams-hotel-1.jpg")
class Places: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data: [placedata] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = loaddata()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func loaddata() -> [placedata] {
        
        var tempdata: [placedata] = []
        
        //this is our select query
        let queryString = "SELECT * FROM places"
        
        //statement pointer
        var stmt:OpaquePointer?
        
        //preparing the query
        if sqlite3_prepare(db, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing insert: \(errmsg)")
        }
        
        //traversing through all the records
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let id = sqlite3_column_int(stmt, 0)
            print(id)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            print(name)
            let description = String(cString:sqlite3_column_text(stmt, 2))
            print(description)
            let image  = String(cString:sqlite3_column_text(stmt, 3))
            print(image)
            let imageurl = URL(string: image)
            let imager:URL = imageurl ?? defimage!
            print(imager)
            let dataelement = placedata(id: Int(id), name: name, description: description, imageurl: imageurl ?? defimage!)
            
            tempdata.append(dataelement)
        
        }
        
        return tempdata
    
    }
    
    
    
}


extension Places: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celldata = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as! PlaceTableViewCell
        
        cell.setData(dataElement: celldata,id: indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        identificationnum = indexPath.row
        performSegue(withIdentifier: "cell", sender: nil)
    }
    
    
    
}
