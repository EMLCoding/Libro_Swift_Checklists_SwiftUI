//
//  ContentView.swift
//  Checklists SwiftUI
//
//  Created by Eduardo Martin Lorenzo on 05/03/2021.
//

import SwiftUI

struct ChecklistView: View {
    // MARK:- Properties
    // Esto permite conectar la View (esto) con el ViewModel (Checklist.swift) - MVVM
    @ObservedObject var checklist = Checklist()
    
    @State var newChecklistItemViewIsVisible = false
    
    var body: some View {
        NavigationView {
            List {
                // id: \.name indica que el identificador de cada elemento del array sera la variable name del propio elemento, es decir, el String del nombre de la tarea.
                // Se termina quitando el id: porque el struct de ChecklistItem tiene el protocolo Identifiable
                // 'self.$checklist.items[index]' se puede hacer gracias a una de las extensiones de la carpeta Extensions
                ForEach(checklist.items) { index in
                    RowView(checklistItem: self.$checklist.items[index])
                }
                // Automaticamente pasa el id del elemento del forEach a traves del parametro "whichElement" de deleteListItem
                .onDelete(perform: checklist.deleteListItem)
                .onMove(perform: checklist.moveListItem)
            }
            // De esta forma se consigue habilitar el modo Edit de la List
            .navigationBarItems(leading: Button(action: {self.newChecklistItemViewIsVisible = true}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Add item")
                }
            },trailing: EditButton())
            .navigationBarTitle("Checklist", displayMode: .inline)
        }
        .onAppear {
            print("ChecklistView has appeared!")
        }
        .onDisappear {
            print("ChecklistView has disappeared!")
        }
        // El .onReceive permite que ChecklistView se suscriba a estos eventos y ejecute un codigo cuando recibe un evento en concreto
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // La aplicacion esta a punto de pasar a segundo plano
            print("willResignActiveNotification")
            self.checklist.saveChecklistItems()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
            // La aplicacion esta en segundo plano
            print("willResignActiveNotification")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // La aplicacion esta a punto de pasar a primer plano
            print("willResignActiveNotification")
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            // La aplicacion ha entrado en primer plano
            print("willResignActiveNotification")
        }
        // Muestra una hoja que se superpone a la pantalla principal
        .sheet(isPresented: $newChecklistItemViewIsVisible) {
            NewChecklistItemView(checklist: self.checklist)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
