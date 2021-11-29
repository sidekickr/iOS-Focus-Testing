//
//  ContentView.swift
//  TestNewTextFocus
//
//  Created by David Siebecker on 11/28/21.
//

import SwiftUI

class FocusedEditor : ObservableObject {
    
    @Published var focusedTextEditor: UUID?
    init(_ uuid: UUID) {
        focusedTextEditor = uuid
    }
}

struct FocusButtonEnvironmentObject: View {
    var id : UUID
    var text: String
    @EnvironmentObject var focusedWrapper: FocusedEditor
    var body: some View {
        Button(text) {
            focusedWrapper.focusedTextEditor = id
        }
    }
}

struct TextFieldWrapperEnvironmentObject : View {
    @ObservedObject var person: Person
    @EnvironmentObject var focusedWrapper: FocusedEditor
    @FocusState private var focused: UUID?
    
    var body: some View {
        HStack {
            TextField("Name",text: $person.name)
                .focused($focused,equals: focusedWrapper.focusedTextEditor)
                .onReceive(focusedWrapper.$focusedTextEditor, perform: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        focused = person.id
                    }
                })
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        focused = person.id
                    }
                }
            FocusButtonEnvironmentObject(id: person.id, text: "Focus")
        }
    }
}

struct ContentViewEnvironmentObject: View {
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
                TextFieldWrapperEnvironmentObject(person: person)
            }
            .environmentObject(firstResponder)
        }
        
    }
}

struct ContentViewEnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewEnvironmentObject()
    }
}
