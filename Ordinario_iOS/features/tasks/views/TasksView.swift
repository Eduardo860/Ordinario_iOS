//
//  TasksView.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 06/12/25.
//
import SwiftUI

struct TasksView: View {
    
    @EnvironmentObject var vm: SchoolViewModel  // Usamos SchoolViewModel
    
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                  
                    TaskFilterBarView()
                        .padding(.top, 16)
                    
                    
                    ForEach(vm.tasks, id: \.id) { task in
                        TaskRowView(
                            title: task.title,
                            subject: task.subject,
                            status: task.status,
                            date: task.dueDate,
                            primaryColor: Color(hex: vm.config?.primaryColor ?? "#63c")
                        )
                    }
                }
                .padding(.horizontal)
            }
            .background(lightBackground.ignoresSafeArea())
            .navigationTitle("Tareas")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    TasksView()
        .environmentObject(SchoolViewModel())  
}
