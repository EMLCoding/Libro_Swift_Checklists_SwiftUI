//
//  NewChecklistItemView.swift
//  Checklists SwiftUI
//
//  Created by Eduardo Martin Lorenzo on 07/03/2021.
//

import SwiftUI

struct NewChecklistItemView: View {
    @State var newItemName = ""
    
    // @Environment permite acceder a configuracion especifica del SO
    @Environment(\.presentationMode) var presentation
    
    // Añadiendo esta variable ya se modifica el constructor de NewChecklistItemView para que se le pueda pasar un objeto Checklist como parametro de entrada
    var checklist: Checklist
    
    var body: some View {
        VStack {
            Text("Add new item")
            Form {
                TextField("Enter item name", text: $newItemName)
                Button(action: {
                    let newChecklistItem = ChecklistItem(name: self.newItemName)
                    self.checklist.items.append(newChecklistItem)
                    self.checklist.printChecklistContents()
                    // Permite ocultar la hoja superpuesta a la pantalla principal
                    self.presentation.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add new item")
                    }
                }
                // Si no se ha escrito nada en el TextLabel entonces el boton estara deshabilitado
                .disabled(newItemName.count == 0)
            }
            .onAppear {
                print("NewChecklistItemView has appeared!")
            }
            .onDisappear {
                print("NewChecklistItemView has disappeared!")
            }
            
            Text("Swipe down to cancel.")
        }
        
    }
}

struct NewChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewChecklistItemView(checklist: Checklist())
    }
}
