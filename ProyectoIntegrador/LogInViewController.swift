//
//  LogInViewController.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 2/11/22.
//

import UIKit
import Foundation

class LogInViewController: UIViewController {
    
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    
    // Diccionario con la informacion del usuario conectado
    typealias typeUser = [String:String]
    var currentUser = typeUser()
    // Diccionario con la informacion de todos los usuarios
    typealias typeAllUsers = [String:typeUser]
    var allUsers:typeAllUsers = typeAllUsers()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actualizarDiccionarioUsuarios()
        lblError.text = ""
        // Do any additional setup after loading the view.
    }
    func actualizarDiccionarioUsuarios (){
        allUsers = UserDefaults.standard.object(forKey: "allUsers") as? [String : [String:String]] ?? typeAllUsers()
    }
    @IBAction func logIn(_ sender: Any) {
        // mirar shouldPerformSegue
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    /**
     Method that search the posible email introduced by the user in the database and returns the anwser
     */
    private func searchUser(emailParam:String, pwdParam:String) -> Bool {
        actualizarDiccionarioUsuarios()
        var userExist:Bool = false
        for myUser in allUsers.keys {
            if (myUser == emailParam){
                userExist = true
                break
            }
        }
        
        if userExist {
            let emailAux:String = allUsers[emailParam]!["email"]!
            let pwdAux:String = allUsers[emailParam]!["pwd"]!
            
            if (emailAux == emailParam && pwdAux == pwdParam) {
                currentUser = allUsers[emailParam]!
                UserDefaults.standard.set(currentUser, forKey: "currentUser")
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    
    func clearFields(){
        txtUsername.text = ""
        txtPassword.text = ""
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let email:String = txtUsername.text ?? ""
        let pwd:String = txtPassword.text ?? ""

        if (identifier == "segueLogIn"){
            if email == "" || pwd == ""{
                lblError.text = "Fill all fields."
                return false
            }

            let semaphore = DispatchSemaphore(value: 0)
            var flag = false
            
            doLogIn(email: email, password: pwd) { (user, error) in
                if let error = error {
                    print(error)
                    flag = false
                    semaphore.signal()
                    return
                }
                
                guard let user = user else {
                    print("User is missing")
                    flag = false
                    semaphore.signal()
                    return
                }
                
                let userDictionary = [
                    "cod_user": String(user.cod_user!),
                    "name": user.name,
                    "surname": user.surname,
                    "email": user.email,
                    "birthday": user.birthday,
                    "password": user.password
                ] as [String : String]
                
                UserDefaults.standard.set(userDictionary, forKey: Config.shared.currentUser)
                flag = true
                print(userDictionary)
                semaphore.signal()
            }
            
            semaphore.wait()
            return flag
        } else {
            clearFields()
            return true
        }
    }


    func doLogIn(email: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        let url = URL(string: "\(Config.shared.staticURL)users/login/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters = ["email": email, "pwd": password]
        let parameterData = parameters.map { "\($0)=\($1)" }.joined(separator: "&").data(using: .utf8)
        request.httpBody = parameterData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Data is missing"])
                completion(nil, error)
                return
            }
            
            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                completion(user, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}
