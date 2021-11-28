//
//  ContentView.swift
//  TestNewTextFocus
//
//  Created by David Siebecker on 11/28/21.
//

import SwiftUI

struct FocusedTextEditorKey: EnvironmentKey {
    static let defaultValue: UUID = UUID()
}

extension EnvironmentValues {
    var focusedTextEditor : UUID {
        get {self[FocusedTextEditorKey.self]}
        set {self[FocusedTextEditorKey.self] = newValue}
    }
}


class Person: ObservableObject, Identifiable {
    
    @Published var name: String = ""
    let id = UUID()

}

class FocusedEditor : ObservableObject {
    
    @Published var focusedTextEditor: UUID?
    init(_ uuid: UUID) {
        focusedTextEditor = uuid
    }
}

struct TextFieldWrapper : View {
    @ObservedObject var person: Person
//    @Environment(\.focusedTextEditor) var focusedUUID
    @EnvironmentObject var focusedWrapper: FocusedEditor
    @FocusState private var focused: UUID?
    
    var body: some View {
        HStack {
            TextField("Name",text: $person.name)
//            .focused($focused,equals: focusedUUID)
                .focused($focused,equals: focusedWrapper.focusedTextEditor)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    focused = person.id
                }
            }
            Button("Focus") {
                focusedWrapper.focusedTextEditor = person.id
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    focused = person.id
                }
            }
        }
    }
}

struct ContentView: View {
    @State var people = [Person]()
    @State var firstResponder = FocusedEditor(UUID())
    @State var focusedUUID = UUID()
    
    var body: some View {
        List {
            Button("Add Person") {
                people.append(Person())
                if let id = people.last?.id {
                    firstResponder.focusedTextEditor = id
                    focusedUUID = id
                }
            }
            ForEach(people) {person in
                TextFieldWrapper(person: person)
            }
//            .environment(\.focusedTextEditor, focusedUUID)
            .environmentObject(firstResponder)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
