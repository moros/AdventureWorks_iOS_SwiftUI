//
//  FakeData.swift
//  AdventureWorks
//
//  Created by dmason on 2/7/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import Foundation

struct FakeData
{
    static func fakeDepartmentListData() -> Data
    {
        let json: String = """
            [
                {
                    "department_id": 1,
                    "group_name": "Research and Development",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Engineering"
                },
                {
                    "department_id": 2,
                    "group_name": "Research and Development",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Tool Design"
                },
                {
                    "department_id": 3,
                    "group_name": "Sales and Marketing",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Sales"
                },
                {
                    "department_id": 4,
                    "group_name": "Sales and Marketing",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Marketing"
                },
                {
                    "department_id": 5,
                    "group_name": "Inventory Management",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Purchasing"
                },
                {
                    "department_id": 6,
                    "group_name": "Research and Development",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Research and Development"
                },
                {
                    "department_id": 7,
                    "group_name": "Manufacturing",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Production"
                },
                {
                    "department_id": 8,
                    "group_name": "Manufacturing",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Production Control"
                },
                {
                    "department_id": 9,
                    "group_name": "Executive General and Administration",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Human Resources"
                },
                {
                    "department_id": 10,
                    "group_name": "Executive General and Administration",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Finance"
                },
                {
                    "department_id": 11,
                    "group_name": "Executive General and Administration",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Information Services"
                },
                {
                    "department_id": 12,
                    "group_name": "Quality Assurance",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Document Control"
                },
                {
                    "department_id": 13,
                    "group_name": "Quality Assurance",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Quality Assurance"
                },
                {
                    "department_id": 14,
                    "group_name": "Executive General and Administration",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Facilities and Maintenance"
                },
                {
                    "department_id": 15,
                    "group_name": "Inventory Management",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Shipping and Receiving"
                },
                {
                    "department_id": 16,
                    "group_name": "Executive General and Administration",
                    "modified_date": "2008-04-30T00:00:00Z",
                    "name": "Executive"
                }
            ]
            """
        
        let data = json.data(using: .utf8)
        return data!
    }
}
