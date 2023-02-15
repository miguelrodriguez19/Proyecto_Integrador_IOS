//
//  configuracion.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 8/2/23.
//

import Foundation

class Config {
    
    let staticURL: String = "http://192.168.64.27:8080/"
    let currentUser: String = "currentUser"
    // Endpoints of users
    let getAllUsers: String = "users"
    let getUserById: String = "users/"
    let postUser: String = "users/"
    let doLogIn: String = "users/login/"
    let putUser:String = "users/" // users/{id}/
    let deleteUser:String = "users/delete/"
    
    // Endpoints of notes
    let getAllNotes:String = "notes"
    let getNoteById:String = "notes/"
    let getNotesByUserId:String = "notes/listByUser/"
    let postNote:String = "notes/"
    let putNote:String = "notes/" // notes/{id}/
    let deleteNote:String = "notes/delete/"
    
    static let shared: Config = {
        let instanciaConfig = Config()
        return instanciaConfig
    }()
}

struct User: Codable {
    let cod_user: Int?
    let name: String
    let surname: String
    let email: String
    let birthday: String
    let password: String
}

struct NotesResponse: Decodable {
    let notes: [Note]
}

struct Note: Codable {
    let cod_note: Int?
    let tittle: String
    let content: String
    let creation_date: String
    let modification_date: String
    let cod_user: Int
}
