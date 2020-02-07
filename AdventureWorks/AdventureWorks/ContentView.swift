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
                DepartmentsView(task: ArrayTask<DepartmentResource, Department>(manager: injectMockSessionManager()))
            }
            .navigationBarTitle(Text("Departments"))
            .navigationBarItems(trailing: HStack {
                NavigationLink(destination: DepartmentInputView()) {
                    Text("Add")
                }
            })
        }
    }
    
    func injectMockSessionManager() -> SessionManagerProtocol
    {
        let responseStore = DefaultResponseStore(data: FakeData.fakeDepartmentListData())
        return SessionManagerMock(responseStore: responseStore)
    }
}

struct DepartmentsView: View {
    
    @ObservedObject private var task: ArrayTask<DepartmentResource, Department>
    
    init(task: ArrayTask<DepartmentResource, Department> = ArrayTask<DepartmentResource, Department>())
    {
        self.task = task
        self.task.loadData()
    }
    
    var body: some View {
        List(task.contents) { department in
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
