//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by 梅清阳 on 2021/7/29.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var assignmentList = AssignmentList()
    @State private var showingAddItemView = false
    var body: some View {
        
        VStack {
            NavigationView {
                List {
                    ForEach(assignmentList.items) {
                        item in
                        HStack {
                            VStack(alignment: .leading)
                            {
                                Text(item.courses).font(.headline)
                                Text(item.description)
                            }
                            Spacer()
                            Text(item.dueDate, style: .date)
                        }
                    }.onMove(perform: {
                        indices, newOffset in
                        assignmentList.items.move(fromOffsets: indices, toOffset: newOffset)
                        })
                    .onDelete(perform: { indexSet in
                        assignmentList.items.remove(atOffsets: indexSet)
                        })
                        }
                        .sheet(isPresented: $showingAddItemView, content: {
                                AddItemView(assignmentList: assignmentList)
                            })
                        .navigationBarTitle("Assignment Notebook", displayMode: .inline)
                        .navigationBarItems(leading: EditButton(),
                                                trailing: Button(action: {
                                                    showingAddItemView = true}) {
                                                    Image(systemName: "plus")
                            })

            }
            Image("background").resizable()
        }
        
}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Assignment: Identifiable, Codable{
    var id = UUID()
    var courses = String()
    var description = String()
    var dueDate = Date()
}
