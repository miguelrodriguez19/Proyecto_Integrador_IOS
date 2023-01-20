//
//  ShoppingListTableViewController.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 2/11/22.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    // var arrayItemsList = [[String:[String:Any]]]()
    
    var arrayItemsList:[String] = ["Lechuga","Pollo","Atun","Huevos","Leche","Cepillo de dientes","Papel higienico"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

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
        cell.lblName.text = arrayItemsList[indexPath.row]
        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func leerDatos(){// -> [String]{
        
        do{
            let misDatosLeidos = try Data(contentsOf: miRutaArchivo())
            arrayItemsList = try JSONSerialization.jsonObject(with: misDatosLeidos) as! [String] ?? []
        }catch _ {
            print("Error fatal de lectura. Sin datos")
        }
        
        // return datos
    }
    
    func getDocumentPath() -> URL
    {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? URL(string: "")!
    }
    
    // devuelve la ruta con todos los documentos del directorio
    func miRutaArchivo() -> URL
    {
        let miPath = getDocumentPath()
        // let miFicheroURL = miPath.appending(path: "Datos.json")
        let miFicheroURL = miPath.appendingPathComponent("Datos.json")
        
        return miFicheroURL
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
            btnCheck.imageView?.image = UIImage(systemName: "square")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: 0))
        }else{
            isCheck = true
            btnCheck.imageView?.image = UIImage(systemName: "multiply.square")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        }
        lblName.attributedText = attributeString
    }
}
