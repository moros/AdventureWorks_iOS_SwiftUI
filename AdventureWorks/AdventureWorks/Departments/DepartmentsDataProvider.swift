//
//  DepartmentsDataProvider.swift
//  AdventureWorks
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class DepartmentsDataProvider: DataProvider<Department>
{
    override func loadData(parameters: Dictionary<String, Any>? = nil)
    {
        guard let url = URL(string: "https://localhost:5002/api/departments/index") else {
            super.updateFetchedData(items: [])
            return
        }
        
        Alamofire.request(URLRequest(url: url)).responseJSON { response in
            let json = JSON(response.result.value!)
            let results = json.arrayValue
            
            var items = [Department]()
            for result in results {
                items.append(Department(
                    id: result["department_id"].intValue,
                    name: result["name"].stringValue,
                    groupName: result["group_name"].stringValue,
                    modified: nil)
                )
            }
            
            DispatchQueue.main.async {
                super.updateFetchedData(items: items)
            }
        }
    }
}
