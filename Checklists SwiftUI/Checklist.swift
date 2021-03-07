//
//  Checklist.swift
//  Checklists SwiftUI
//
//  Created by Eduardo Martin Lorenzo on 05/03/2021.
//

import Foundation

// Esto es el ViewModel del MVVM. Es donde se realizan las acciones sobre los objetos del Model que se muestran en la View

// Como Checklist debe ser accesible desde diferentes puntos de la app, debe ser una class y no un struct, ya que las clases son tipos por referencia.
// Debe tener el protocolo ObservableObject para que la View pueda obsevar a la ViewModel (que es esta). Modelo MVVM
class Checklist: ObservableObject {
    // En el ChecklistView esta variable seria @State, pero aqui, en el ViewModel, debe ser @Published. Esto permite que cualquier cambio de este array se notifique a la View para actualizar la UI
    @Published var items: [ChecklistItem] = []
    
    init() {
        loadChecklistItems()
    }
    
    func deleteListItem(whichElement: IndexSet) {
        items.remove(atOffsets: whichElement)
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int) {
        items.move(fromOffsets: whichElement, toOffset: destination)
    }
    
    func printChecklistContents() {
        for item in items {
            print(item)
        }
    }
    
    // MARK:- File management
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let directory = paths[0]
        print("Documents directory is \(directory)")
        return directory
    }
    
    func dataFilePath() -> URL {
        let filePath = documentsDirectory().appendingPathComponent("Checklist.plist")
        print("Data file path is: \(filePath)")
        return filePath
    }
    
    func saveChecklistItems() {
        print("Saving checklist items")
        // Se crea una instancia de PropertyListEncoder que permite codificar un conjunto de datos en una lista de propiedades
        let encoder = PropertyListEncoder()
        
        do {
            // Codifica el array de datos
            let data = try encoder.encode(items)
            
            // Escribe los datos codificaods en un archivo
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            
            print("Checklist items saved")
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklistItems() {
        print("Loading checklist items")
        
        let path = dataFilePath()
        // Busca los datos en la ubicacion dada por dataFilePath()
        if let data = try? Data(contentsOf: path) {
            // Se crea la instancia para decodificar la informacion
            let decoder = PropertyListDecoder()
            do {
                // Se guarda en items los datos de data en formato ChecklistItem
                items = try decoder.decode([ChecklistItem].self, from: data)
                print("Checklist items loaded")
            } catch {
                print("Error decoding item array: \(error.localizedDescription)")
            }
        }
    }
    
}
