//
//  ListasViewController.swift
//  ProyectoIntegrador
//
//  Created by Ignacio Moreno Fernández on 20/1/23.
//

import UIKit

class ListasViewController: UIViewController {

    
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet var labelListaSeleccionada: UILabel!
    var intercambio: String?
    var intercambioContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelListaSeleccionada.text = intercambio
        textViewContent.text = intercambioContent
        // Do any additional setup after loading the view.
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        labelListaSeleccionada.text = intercambio
    }*/
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


