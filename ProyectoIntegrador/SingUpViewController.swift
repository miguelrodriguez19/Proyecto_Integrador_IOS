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
    @IBOutlet weak var txtEmail: UITextField!
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
        allUsers = UserDefaults.standard.object(forKey: "allUsers") as? [String : [String:String]] ?? typeAllUsers()
    }
    
    @IBAction func signUp(_ sender: Any) {
        let name = txtName.text
        let email = txtEmail.text
        let pwd = txtPassword.text
        
        if (name != "" && email != "" && pwd != ""){
            // Queda comprobar si el key existe
                userInfo["name"] = name!
                userInfo["email"] = email!
                userInfo["pwd"] = pwd!
                allUsers[email!] = userInfo
                
                print(allUsers)
                
                UserDefaults.standard.set(allUsers, forKey: "allUsers")
            txtName.text = 
                txtPassword.text
                lblError.text = ""
                self.dismiss(animated: true)
            }else{
            lblError.text = "Fill all fields"
        }
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
