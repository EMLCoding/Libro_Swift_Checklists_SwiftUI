//
//  ChecklistItem.swift
//  Checklists SwiftUI
//
//  Created by Eduardo Martin Lorenzo on 05/03/2021.
//

import Foundation

// Esto es el Model del MVVM. En el Model deben ir los objetos que se van a utilizar y mostrar
// Codable es necesario para poder guardar los elementos de la checklist en la memoria del telefono
struct ChecklistItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var isChecked: Bool = false
}
