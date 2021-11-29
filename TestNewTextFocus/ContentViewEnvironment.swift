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


//struct FocusButtonEnvironment: View {
//    var id : UUID
//    var text: String
//    @Environment var focusedWrapper: FocusedEditor
//    var body: some View {
//        Button(text) {
//            focusedWrapper.focusedTextEditor = id
//        }
//    }
//}

struct TextFieldWrapperEnvironment : View {
    @ObservedObject var person: Person
    @Environment(\.focusedTextEditor) var focusedUUID
    @FocusState private var focused: UUID?
    
    var body: some View {
        HStack {
            TextField("Name",text: $person.name)
                .focused($focused,equals: focusedUUID)
//                .onReceive($focusedUU, perform: { _ in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
//                        focused = person.id
//                    }
//                })
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        focused = person.id
                    }
                }
//            FocusButtonEnvironment(id: person.id, text: "Focus", focusedWrapper: <#Environment<FocusedEditor>#>)
        }
    }
}

struct ContentViewEnvironment: View {
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
                TextFieldWrapperEnvironment(person: person)
            }
            .environment(\.focusedTextEditor, focusedUUID)
        }
        
    }
}

struct ContentViewEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewEnvironment()
    }
}
