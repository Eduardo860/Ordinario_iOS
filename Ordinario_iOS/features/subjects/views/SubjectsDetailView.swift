import SwiftUI

struct SubjectDetailView: View {
    
    let subjectName: String
    let schedule: String
    
    @EnvironmentObject var vm: SchoolViewModel
    
    private let lightBackground = Color(red: 0.95, green: 0.95, blue: 0.97)
    
    var body: some View {
        // Usamos config dinámica
        let config = vm.config ?? SchoolConfig.preview
        let primaryColor = Color(hex: config.primaryColor)
        
        ScrollView {
            VStack(spacing: 24) {
                
                // Encabezado de la materia
                VStack(alignment: .leading, spacing: 8) {
                    Text(subjectName)
                        .font(.largeTitle.bold())
                        .foregroundColor(primaryColor)
                    
                    Text(schedule)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Tarjeta de información
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundColor(primaryColor)
                        Text("Profesor:")
                            .font(.headline)
                        Spacer()
                        Text("Pendiente")
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(primaryColor)
                        Text("Horario:")
                            .font(.headline)
                        Spacer()
                        Text(schedule)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Image(systemName: "building.columns")
                            .foregroundColor(primaryColor)
                        Text("Aula:")
                            .font(.headline)
                        Spacer()
                        Text("Por definir")
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.06), radius: 8)
                )
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .background(lightBackground.ignoresSafeArea())
        .navigationTitle("Detalle de materia")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    SubjectDetailView(
        subjectName: "Cálculo Integral",
        schedule: "Lun / Mié · 10:00 - 11:30"
    )
    .environmentObject(SchoolViewModel())  
}
