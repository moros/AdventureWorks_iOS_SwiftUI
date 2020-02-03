//
//  ContentView.swift
//  AdventureWorks
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            DepartmentsView()
        }
    }
}

struct DepartmentsView: View {
    
    @ObservedObject private var provider: DataProvider<Department>
    
    init(provider: DataProvider<Department> = DepartmentsDataProvider())
    {
        self.provider = provider
        self.provider.loadData()
    }
    
    var body: some View {
        List(provider.fetchedData) { department in
            Text(department.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
