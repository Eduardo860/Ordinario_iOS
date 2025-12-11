import SwiftUI

struct TaskFilterBarView: View {
    
    @EnvironmentObject var vm: SchoolViewModel 
    
    @State private var selectedFilter = "Pendientes"
    
    private let filters = ["Pendientes", "Entregadas", "Todas"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                
                ForEach(filters, id: \.self) { filter in
                    Button {
                        selectedFilter = filter
                    } label: {
                        Text(filter)
                            .font(.subheadline)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(filter == selectedFilter ?
                                          Color(hex: vm.config?.primaryColor ?? "#63c" ).opacity(0.15) :
                                          Color.white)
                            )
                            .foregroundColor(filter == selectedFilter ? Color(hex: vm.config?.primaryColor ?? "#63c") : .gray)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(filter == selectedFilter ?
                                                  Color(hex: vm.config?.primaryColor ?? "#63c").opacity(0.5) :
                                                  Color.gray.opacity(0.3))
                            )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TaskFilterBarView()
            .environmentObject(SchoolViewModel())
}
