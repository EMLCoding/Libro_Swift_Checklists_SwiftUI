//
//  EditChecklistItemView.swift
//  Checklists SwiftUI
//
//  Created by Eduardo Martin Lorenzo on 05/03/2021.
//

import SwiftUI

struct EditChecklistItemView: View {
    
    // MARK:- Properties
    // Hay que usar @Binding para que el checklistItem que llega a esta pantalla sea una referencia del checklistItem original, asi los cambios se aplicaran en el original. Si se usara @State se estaria recibiendo una copia por valor
    @Binding var checklistItem: ChecklistItem
    var body: some View {
        Form {
            TextField("Name", text: $checklistItem.name)
            Toggle("Completed", isOn: $checklistItem.isChecked)
        }
        .onAppear {
            print("EditChecklistItemView has appeared!")
        }
        .onDisappear {
            print("EditChecklistItemView has disappeared!")
        }
    }
}

struct EditChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        // Se usa .constant porque se esta usando @Binding para checklisItem en vez de @State, ya que se le pasa un elemento por referencia y no por valor
        EditChecklistItemView(checklistItem: .constant(ChecklistItem(name: "Sample item")))
    }
}
