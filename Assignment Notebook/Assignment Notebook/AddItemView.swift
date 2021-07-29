//
//  AddItemView.swift
//  Assignment Notebook
//
//  Created by 梅清阳 on 2021/7/29.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var assignmentList: AssignmentList
        @State private var courses = ""
        @State private var description = ""
        @State private var dueDate = Date()
    @Environment(\.presentationMode) var presentationMode
        static let subjects = ["Maths", "Computer Science", "English"]
    var body: some View {
        NavigationView {
            Form {
                Picker("Course", selection: $courses) {
                        ForEach(Self.subjects, id: \.self) { courses in
                                Text(courses)
                            }
                        }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    }
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
                                
                                .navigationBarItems(trailing: Button("Save") {
                                                if courses.count > 0 && description.count > 0 {
                                                    let item = Assignment(id: UUID(), courses: courses,
                                                                        description: description, dueDate: dueDate)
                                                    assignmentList.items.append(item)
                                                    presentationMode.wrappedValue.dismiss()
                                                }
                                            })
            
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(assignmentList: AssignmentList())
    }
}
