//
//  ContentView.swift
//  ToDoList
//
//  Created by Afra Ibnat on 6/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var showNewTask = false
    @Query var toDos: [ToDoItem]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            HStack {
                // Displays to-do list
                Text("PACKING LIST")
                    .font(.system(size: 40))
                    .fontWeight(.black)
                    .multilineTextAlignment(.center)
                
                
                Spacer()
                
                Button {
                    withAnimation {
                        self.showNewTask = true
                    }
                } label: {
                    Text("+")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.purple)
                }
            }
            .padding()
        }
        Spacer()
        
        List {
            ForEach(toDos) { toDoItem in
                if toDoItem.isImportant == true {
                    Text("‼️" + toDoItem.title)
                } else {
                    Text(toDoItem.title)
                    }
            }
            // swipe-to-delete
            .onDelete(perform: deleteToDo)
        }
        .listStyle(.plain)
        
        if showNewTask {
            NewToDoView(toDoItem: ToDoItem(title: "", isImportant: false), showNewTask: $showNewTask)
        }
    }
    func deleteToDo(at offsets: IndexSet) {
        for offset in offsets {
            let toDoItem = toDos[offset]
            modelContext.delete(toDoItem)
        }
    }
}

#Preview {
    ContentView()
}
