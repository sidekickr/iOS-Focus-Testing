//
//  ContentView.swift
//  TestNewTextFocus
//
//  Created by David Siebecker on 11/28/21.
//

import SwiftUI

struct FocusButtonVariablePassing: View {
  var id: UUID
  var text: String
  var focused: FocusState<UUID?>.Binding
  var body: some View {
    Button(text) {
        focused.wrappedValue = id
    }
  }
}

struct TextFieldWrapperVariablePassing : View {
    @ObservedObject var person: Person
    var focused: FocusState<UUID?>.Binding

    var body: some View {
        HStack {
            TextField("Name",text: $person.name)
                .focused(focused,equals: person.id)
            FocusButtonVariablePassing(id: person.id, text: "Focus", focused: focused)
        }
    }
}

struct ContentViewVariablePassing: View {
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
                TextFieldWrapperVariablePassing(person: person, focused: $focused)
            }
        }
        
    }
}

struct ContentViewVariablePassing_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewVariablePassing()
    }
}
