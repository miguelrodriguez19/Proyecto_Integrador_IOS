//
//  NewNoteViewController.swift
//  ProyectoIntegrador
//
//  Created by Ignacio Moreno Fernández on 1/2/23.
//

import UIKit

class NewNoteViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtContent: UITextView!
    @IBOutlet weak var lblError: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func save(_ sender: Any) {
        let title = txtTitle.text ?? ""
        let content = txtContent.text ?? ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        
        let user = UserDefaults.standard.object(forKey: Config.shared.currentUser) as! [String:String]
        let codUser = user["cod_user"]!
           if (title != "" || content != "") {
               let note = Note(cod_note: nil, tittle: title, content: content, creation_date: dateString, modification_date: dateString, cod_user: Int(codUser)!)
               createNote(note: note) { (error) in
                   if let error = error as NSError? {
                       print("Error creating Note.")
                       return
                   }
                   
                   DispatchQueue.main.async {
                       self.txtTitle.text = ""
                       self.txtContent.text = ""
                       self.lblError.text = ""
                       self.navigationController?.popViewController(animated: true)
                   }
               }
           } else {
               lblError.text = "You must fill at least one field."
           }
    }
    
    func createNote(note: Note, completion: @escaping (_ error: Error?) -> Void) {
        guard let url = URL(string: "\(Config.shared.staticURL)notes/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
