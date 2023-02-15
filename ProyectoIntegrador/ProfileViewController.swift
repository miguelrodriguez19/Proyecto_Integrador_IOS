//
//  ProfileViewController.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 2/11/22.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblSurname: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    
    typealias typeUser = [String:String]
    var currentUser = typeUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = UserDefaults.standard.object(forKey: Config.shared.currentUser) as! [String:String]
        
        lblUserName.text = currentUser["name"]
        lblUserEmail.text = currentUser["email"]
        lblSurname.text = currentUser["surname"]
        lblBirthday.text = currentUser["birthday"]
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        let miStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        self.tabBarController?.dismiss(animated: true)
        
        }
        
        
       // present(logInView!, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


