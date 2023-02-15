//
//  ListasViewController.swift
//  ProyectoIntegrador
//
//  Created by Ignacio Moreno Fernández on 20/1/23.
//

import UIKit

class ListasViewController: UIViewController {

    
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet var txtViewTitle: UITextField!
    @IBOutlet weak var lblError: UILabel!
    var noteIntercambio: Note? = nil
    var intercambio: String?
    var intercambioContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtViewTitle.text = noteIntercambio?.tittle
        textViewContent.text = noteIntercambio?.content
        // Do any additional setup after loading the view.
    }
    
    func exitScreen(){
        self.txtViewTitle.text = ""
        self.textViewContent.text = ""
        self.lblError.text = ""
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete All", message: "Do you want to delete all items?", preferredStyle: .alert)
        
        
        let alertButtonAcept = UIAlertAction(title: "Yes", style: .destructive)
        {
            (done) in
            self.deleteNote(){ (error) in
                if let error = error as NSError? {
                    print("Error deleting Note.")
                    return
                }
                
                DispatchQueue.main.async {
                    self.exitScreen()
                }
            }
        }
        
        let alertButton = UIAlertAction(title: "No", style: .default)
        {
            (done) in
        }
        alertController.addAction(alertButton)
        alertController.addAction(alertButtonAcept)
        present(alertController, animated: true)
    }
    
    
    func deleteNote(completion: @escaping (_ error: Error?) -> Void) {
        let codNote = Int(noteIntercambio?.cod_note ?? 0 )
        guard let url = URL(string: "\(Config.shared.staticURL)notes/delete/\(codNote)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(error)
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    let apiError = NSError(domain: "APIError", code: httpResponse.statusCode, userInfo: nil)
                    completion(apiError)
                    return
                }
            }
            completion(nil)
        }
        task.resume()
    }
    
    @IBAction func save(_ sender: Any) {
        let title = txtViewTitle.text ?? ""
        let content = textViewContent.text ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        
        let user = UserDefaults.standard.object(forKey: Config.shared.currentUser) as! [String:String]
        let codUser = user["cod_user"]!
           if (!(title == noteIntercambio?.tittle && content == noteIntercambio?.content)) {
               let note = Note(cod_note: Int((noteIntercambio?.cod_note)!), tittle: title, content: content, creation_date: dateString, modification_date: dateString, cod_user: Int(codUser)!)
               updateNote(note: note) { (error) in
                   if let error = error as NSError? {
                       print("Error saving Note.")
                       return
                   }
                   
                   DispatchQueue.main.async {
                       self.exitScreen()
                   }
               }
           } else {
               lblError.text = "You must update at least one field."
           }
    }

    func updateNote(note: Note, completion: @escaping (_ error: Error?) -> Void) {
        guard let url = URL(string: "\(Config.shared.staticURL)notes/\(note.cod_note!)/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(note)
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
               if httpResponse.statusCode != 200 {
                    let apiError = NSError(domain: "APIError", code: httpResponse.statusCode, userInfo: nil)
                    completion(apiError)
                    return
                }
            }
            completion(nil)
        }
        task.resume()
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


