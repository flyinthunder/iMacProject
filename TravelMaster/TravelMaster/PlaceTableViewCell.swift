//
//  PlaceTableViewCell.swift
//  travelguide
//
//  Created by Admin on 27/04/19.
//  Copyright © 2019 Imac. All rights reserved.
//

import UIKit


class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var makerImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    func setData(dataElement: placedata,id: Int) {
        
        placeNameLabel.text = dataElement.name
        placeimage(imageurl: dataElement.imageurl,id: id)
        locationLabel.text = ""
        
    }
    
    func placeimage(imageurl: URL,id:Int) {
        
        let url = imageurl
        let imgtask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let rawImage = data
            {
                print("TheData:\(rawImage)")
                let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let savePath = path[0] + "/\(id).jpg"
                FileManager.default.createFile(atPath: savePath, contents: rawImage, attributes: nil)
                DispatchQueue.main.async
                    {
                        self.placeImageView.image = UIImage(named: savePath)
                }
            }
        }
        imgtask.resume()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
   
}
