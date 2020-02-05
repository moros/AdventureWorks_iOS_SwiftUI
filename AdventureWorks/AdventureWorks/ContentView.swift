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
            VStack {
                DepartmentsView()
            }
            .navigationBarTitle(Text("Departments"))
            .navigationBarItems(trailing: HStack {
                NavigationLink(destination: DepartmentInputView()) {
                    Text("Add")
                }
            })
        }
    }
}

struct DepartmentsView: View {
    
    @ObservedObject private var provider: ArrayContext<DepartmentResource, Department>
    
    init(provider: ArrayContext<DepartmentResource, Department> = ArrayContext<DepartmentResource, Department>())
    {
        self.provider = provider
        self.provider.loadData()
    }
    
    var body: some View {
        List(provider.contents) { department in
            VStack(alignment: .leading) {
                Text(department.name)
                Text("last modified: \(department.modified)")
            }
        }
    }
}

struct DepartmentInputView: View {
    
    @State private var name: String = ""
    @State private var group: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Form {
                    Section {
                        TextField("Enter the departments name", text: $name)
                    }
                    Section {
                        TextField("Enter the group name", text: $group)
                    }
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
