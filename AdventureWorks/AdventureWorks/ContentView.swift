//
//  ContentView.swift
//  AdventureWorks
//
//  Created by dmason on 2/3/20.
//  Copyright © 2020 United Fire Group. All rights reserved.
//

import SwiftUI
import AlamofireExtended

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                DepartmentsView(context: ArrayContext<DepartmentResource, Department>(manager: injectMockSessionManager()))
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
    
    @ObservedObject private var context: ArrayContext<DepartmentResource, Department>
    
    init(context: ArrayContext<DepartmentResource, Department> = ArrayContext<DepartmentResource, Department>())
    {
        self.context = context
        self.context.loadData(withParameters: nil) { items in
        }
    }
    
    var body: some View {
        List(context.array) { department in
            VStack(alignment: .leading) {
                Text("\(department.name!)")
                Text("last modified: \(department.modified!)")
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
