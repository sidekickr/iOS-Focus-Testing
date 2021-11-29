//
//  Person.swift
//  TestNewTextFocus
//
//  Created by David Siebecker on 11/28/21.
//

import Foundation

class Person: ObservableObject, Identifiable {
    
    @Published var name: String = ""
    let id = UUID()
    
}

