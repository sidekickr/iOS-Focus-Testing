//
//  ContentView.swift
//  TestNewTextFocus
//
//  Created by David Siebecker on 11/28/21.
//

import SwiftUI

class FocusedEditorBinding : ObservableObject {
    
    var focused: FocusState<UUID?>.Binding
    
    init(_ initial: FocusState<UUID?>.Binding) {
        focused = initial
    }
}

struct FocusButtonBindingEnvironmentObject: View {
  var id: UUID
  var text: String
  @EnvironmentObject var focused: FocusedEditorBinding
    
  var body: some View {
    Button(text) {
        focused.focused.wrappedValue = id
    }
  }
}

struct TextFieldWrapperBindingEnvironmentObject : View {
    @ObservedObject var person: Person
    @EnvironmentObject var focused: FocusedEditorBinding

    var body: some View {
        HStack {
            TextField("Name",text: $person.name)
                .focused(focused.focused,equals: person.id)
            FocusButtonBindingEnvironmentObject(id: person.id, text: "Focus")
        }
    }
}

struct ContentViewBindingEnvironmentObject: View {
    @State var people = [Person]()
    @FocusState private var focused: UUID?
    
    var body: some View {
        List {
            Button("Add Person") {
                let person = Person()
                people.append(person)
                DispatchQueue.main.async {
                    focused = person.id
                }
            }
            ForEach(people) {person in
                TextFieldWrapperBindingEnvironmentObject(person: person)
            }
            .environmentObject(FocusedEditorBinding($focused))
        }
    }
}

struct ContentViewBindingEnvironmentObject_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewVariablePassing()
    }
}
