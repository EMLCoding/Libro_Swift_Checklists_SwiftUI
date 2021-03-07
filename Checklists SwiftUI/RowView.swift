//
//  RowView.swift
//  Checklists SwiftUI
//
//  Created by Eduardo Martin Lorenzo on 07/03/2021.
//

import SwiftUI

struct RowView: View {
    // MARK:- Properties
    // Hay que usar @Binding para que el checklistItem que llega a esta pantalla sea una referencia del checklistItem original, asi los cambios se aplicaran en el original. Si se usara @State se estaria recibiendo una copia por valor
    @Binding var checklistItem: ChecklistItem
    
    var body: some View {
        // De esta forma, cuando se toque en alguna parte del HStack, se navegara a la pantalla EditChecklistItemView.
        // En el NavigationLink se le pasa una copia por referencia de la variable checklistItem (por eso el $)
        NavigationLink(destination: EditChecklistItemView(checklistItem: $checklistItem)) {
            HStack {
                Text(checklistItem.name)
                Spacer()
                Text(checklistItem.isChecked ? "✅" : "🔲")
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(checklistItem: .constant(ChecklistItem(name: "Sample item")))
    }
}
