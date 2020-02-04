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
    
    @ObservedObject private var provider: ArrayDataProvider<Department>
    
    init(provider: ArrayDataProvider<Department> = DepartmentsArrayDataProvider())
    {
        self.provider = provider
        self.provider.loadData()
    }
    
    var body: some View {
        List(provider.contents) { department in
            Text(department.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
