//
//  ShoppingListTableViewController.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 2/11/22.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    @IBOutlet var table: UITableView!
    typealias myItem = [String: Any]
    typealias diccionarioItems = [String:myItem]
    
    typealias typeUser = [String:String]
    var currentUser = typeUser()
    
    let JSONFile = "listOfItemsByUsers.json"
    let allColors = ["Blue":UIColor.systemBlue, "Red":UIColor.red, "Yellow":UIColor.yellow,"Green":UIColor.green,"Brown":UIColor.brown,"Orange":UIColor.orange,"Gray":UIColor.gray]
    
    var arrayItemsList:[diccionarioItems] = [diccionarioItems]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String:String]
        var contentJSON = readContentJSON()
        arrayItemsList = contentJSON[currentUser["email"]!] ?? []
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewDidAppear(_ animated: Bool) {
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as! [String:String]
        var contentJSON = readContentJSON()
        arrayItemsList = contentJSON[currentUser["email"]!] ?? []
        self.table.reloadData()
    }
    
    @IBAction func deleteAllItems(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete All", message: "Do you want to delete all items?", preferredStyle: .alert)
        
        
        let alertButtonAcept = UIAlertAction(title: "Yes", style: .destructive)
        {
            (done) in
            self.arrayItemsList.removeAll()
            self.updateJSON(newArr: self.arrayItemsList)
            self.table.reloadData()
        }
        
        let alertButton = UIAlertAction(title: "No", style: .default)
        {
            (done) in
        }
        alertController.addAction(alertButton)
        alertController.addAction(alertButtonAcept)
        if (arrayItemsList.count > 0) {
        present(alertController, animated: true)
    
        }
    }
    // ----------------------------- JSON Methods -----------------------------
    func readContentJSON() -> [String: [diccionarioItems]] {
        var data: [String: [diccionarioItems]] = [String: [diccionarioItems]]()
        
        do{
            let misDatosLeidos = try Data(contentsOf: pathToFile(fileName: JSONFile))
            
            data = try JSONSerialization.jsonObject(with: misDatosLeidos) as! [String: [diccionarioItems]] ?? [String: [diccionarioItems]]()
        }catch _ {
            print("Error fatal de lectura. Sin datos")
        }
        
        return data
    }
    
    // Localiza en el fileManager la carpeta de usuario
    func getDocumentPath() -> URL
    {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? URL(string: "")!
    }
    
    // devuelve la ruta con todos los documentos del directorio
    func pathToFile(fileName: String) -> URL
    {
        let miPath = getDocumentPath()
        // let miFicheroURL = miPath.appending(path: "Datos.json")
        let miFicheroURL = miPath.appendingPathComponent(fileName)
        return miFicheroURL
    }
    
    func updateJSON(newArr: [diccionarioItems])
    {
        var finalDicc = readContentJSON()
        finalDicc[currentUser["email"]!] = newArr
        saveJSON(globalDiccToSave: finalDicc)
    }
    
    func saveJSON(globalDiccToSave: [String: [diccionarioItems]]){
        do{
            let misDatoserializados = try JSONSerialization.data(withJSONObject: globalDiccToSave)
            try misDatoserializados.write(to: pathToFile(fileName: JSONFile))
        }catch _ {
                print("Error guardando el archivo")
        }
    }
    // ----------------------------- Table Methods -----------------------------
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayItemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! itemCell
        // Configure the cell...
        let item = arrayItemsList[indexPath.row]["producto"]
        cell.lblName.text = item?["name"] as! String
        cell.colorTag.tintColor = allColors[item?["color"] as! String]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let optBorrar = UIContextualAction(style: .normal, title: "Delete") { action, view, completion in
            self.arrayItemsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.updateJSON(newArr: self.arrayItemsList)
            self.table.reloadData()
            
        }
        optBorrar.image = UIImage(systemName: "trash")
        optBorrar.backgroundColor = UIColor.red
        /*
        let optAnadir = UIContextualAction(style: .normal, title: "Añadir") { action, view, completion in
           print("Hemos añadido")
        }
        optAnadir.image = UIImage(systemName: "plus")
        optAnadir.backgroundColor = UIColor.green
        */
        let config = UISwipeActionsConfiguration(actions: [optBorrar/*, optAnadir*/])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
class itemCell: UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var colorTag: UIImageView!
    var isCheck = false
    
    @IBAction func checkItem(_ sender: Any) {
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: lblName.text!)
        
        if isCheck {
            isCheck = false
      
            
          
            btnCheck.setImage( UIImage(systemName: "square"), for: .normal)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: 0))
        }else{
            isCheck = true
       
            btnCheck.setImage( UIImage(systemName: "multiply.square"), for: .normal)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        }
        lblName.attributedText = attributeString
    }
}

