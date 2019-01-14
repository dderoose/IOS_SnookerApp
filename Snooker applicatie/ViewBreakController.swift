//
//  ViewBreakController.swift
//  Snooker applicatie
//
//  Created by Dennis Deroose on 14/01/2019.
//  Copyright © 2019 Dennis Deroose. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class ViewBreakController: UIViewController {
    
    @IBOutlet weak var tableBreakView: UITableView!
    
    var listBreakss:Array<Breaks> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableBreakView.rowHeight = 60.0
        
        print(Constants.token)
        
        Alamofire.request("http://backendapplications.azurewebsites.net/api/Breaks").responseData { response in
            //debugPrint("All Response Info: \(response)")
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                let data: NSData = utf8Text.data(using: String.Encoding.utf8)! as NSData
                var _: NSError?
                
                do {
                    let jsonResult : AnyObject? = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as AnyObject
                    let breakListArray = (jsonResult as! NSArray) as Array
                    print(breakListArray)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


