//
//  ContentView.swift
//  TestNewTextFocus
//
//  Created by David Siebecker on 11/28/21.
//

/**
 * I could never get this one to work right
 */

import SwiftUI

struct FocusedTextEditorBindingKey: EnvironmentKey {
    @FocusState static var stub: UUID?
    static var defaultValue: FocusState<UUID?>.Binding { $stub } // runtime warning
}

extension EnvironmentValues {
    var focusedBinding: FocusState<UUID?>.Binding {
        get { self[FocusedTextEditorBindingKey.self] }
        set { self[FocusedTextEditorBindingKey.self] = newValue }
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

struct TextFieldWrapperBindingEnvironment : View {
    @ObservedObject var person: Person
    @Environment(\.focusedBinding) var focused
    
    var body: some View {
        HStack {
            TextField("Name",text: $person.name)
                .focused(focused,equals: person.id)
//                .onReceive($focusedUU, perform: { _ in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
//                        focused = person.id
//                    }
//                })
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        focused.wrappedValue = person.id
                    }
                }
//            FocusButtonEnvironment(id: person.id, text: "Focus", focusedWrapper: <#Environment<FocusedEditor>#>)
        }
    }
}

struct ContentViewBindingEnvironment: View {
    @State var people = [Person]()
    @Environment(\.focusedBinding) var focused

    var body: some View {
        List {
            Button("Add Person") {
                people.append(Person())
                if let id = people.last?.id {
                    focused.wrappedValue = id
                }
            }
            ForEach(people) {person in
                TextFieldWrapperBindingEnvironment(person: person)
            }
        }
        
    }
}

struct ContentViewBindingEnvironment_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewEnvironment()
    }
}
