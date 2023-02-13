//
//  configuracion.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 8/2/23.
//

import Foundation

class ApiRest {
    
    let staticURL: String = "http://192.168.156.27:8080/"
    
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
    
    static let shared: ApiRest = {
        let instanciaApiRest = ApiRest()
        return instanciaApiRest
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
