//
//  SingUpViewController.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 3/11/22.
//

import UIKit

class SingUpViewController: UIViewController {
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtSurname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var lblError: UILabel!
    // Diccionario con la informacion de un usuario
    typealias typeUser = [String:String]
    var userInfo:typeUser = typeUser()
    // Diccionario con la informacion de todos los usuarios
    typealias typeAllUsers = [String:typeUser]
    var allUsers:typeAllUsers = typeAllUsers()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Actualizar el contenido del diccionario
        //allUsers = UserDefaults.standard.object(forKey: "allUsers") as? [String : [String:String]] ?? typeAllUsers()
    }
    
    @IBAction func goLogIn(_ sender: Any) {
        self.txtName.text = ""
        self.txtSurname.text = ""
        self.txtEmail.text = ""
        self.txtDate.text = ""
        self.txtPassword.text = ""
        self.lblError.text = ""
        self.dismiss(animated: true)
    }
    @IBAction func signUp(_ sender: Any) {
            let name = txtName.text ?? ""
            let email = txtEmail.text ?? ""
            let pwd = txtPassword.text ?? ""
            let surname = txtSurname.text ?? ""
            let date = txtDate.text ?? "2023-01-01"
               if (name != "" && email != "" && surname != "" && date != "" && pwd != "" ) {
                   let user = User(cod_user: nil, name: name, surname: surname, email: email, birthday: date, password: pwd)
                   createUser(user: user) { (error) in
                       if let error = error as NSError? {
                           if error.code == 400 {
                               DispatchQueue.main.async {
                                   self.lblError.text = "Email already exists in the database"
                               }
                               return
                           }else{
                               DispatchQueue.main.async {
                                   self.lblError.text = "Error creating User. Try later."
                               }
                           }
                           
                           print("Error creating User.")
                           return
                       }
                       
                       DispatchQueue.main.async {
                           self.txtName.text = ""
                           self.txtSurname.text = ""
                           self.txtEmail.text = ""
                           self.txtDate.text = ""
                           self.txtPassword.text = ""
                           self.lblError.text = ""
                           self.dismiss(animated: true)
                       }
                   }
               } else {
                   lblError.text = "Fill all fields"
               }
        }

    
    func createUser(user: User, completion: @escaping (_ error: Error?) -> Void) {
        guard let url = URL(string: "\(Config.shared.staticURL)users/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            completion(error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 400 {
                    let apiError = NSError(domain: "APIError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "El email ya existe en la base de datos"])
                    completion(apiError)
                    return
                } else if httpResponse.statusCode != 200 {
                    let apiError = NSError(domain: "APIError", code: httpResponse.statusCode, userInfo: nil)
                    completion(apiError)
                    return
                }
            }
            
            completion(nil)
        }
        
        task.resume()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
