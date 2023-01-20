//
//  NewItemShoppingListViewController.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 3/11/22.
//

import UIKit

class NewItemShoppingListViewController:  UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var colorPreview: UIImageView!
    @IBOutlet weak var colorPicker: UIPickerView!
    let JSONFile = "lista.json"
    var colorSeleccionado:String = ""
    var colorArray = [String]()
    let allColors = ["Blue":UIColor.systemBlue, "Red":UIColor.red, "Yellow":UIColor.yellow,"Green":UIColor.green,"Brown":UIColor.brown,"Orange":UIColor.orange,"Gray":UIColor.gray]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (myColor) in allColors.keys.sorted() // <!>Importante Se organizan las claves por orden alfabetico<!>
        {
            colorArray.append(myColor)
        }
        colorSeleccionado = colorArray[0]
        colorPreview.tintColor = allColors[colorArray[0]]
    }
    
    /**
                Create a cell and add it to the shoppingList
     */
    @IBAction func addItem(_ sender: Any) {
        // Crea y añade una celda a la lista de la pantalla anterior
        let cellInfo = txtName.text ?? ""
        let cellColor = (allColors[colorSeleccionado]!).hexString
        if cellInfo != "" {
            let myItem = ItemList(itemName: cellInfo, itemColorInHex: cellColor)
            
            addItemToJSON(itemList: myItem)
            
            navigationController?.popViewController(animated: true)
            
            txtName.text = ""
            lblError.text = ""
        }else{
            lblError.text = "Fill all fields."
        }
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
    
    func addItemToJSON(itemList: ItemList)
    {
        let newArray = [itemList]
        if (readContentJSON().isEmpty){
            saveJSON(arrayToSave: newArray)
        }else{
            let finalArray = readContentJSON() + newArray
            saveJSON(arrayToSave: finalArray)
        }
    }
    
    func saveJSON(arrayToSave: [Any]){
        do{
            let misDatoserializados = try JSONSerialization.data(withJSONObject: arrayToSave)
            try misDatoserializados.write(to: pathToFile(fileName: JSONFile))
        }catch _ {
                print("Error guardando el archivo")
        }
    }
    
    func readContentJSON() -> [ItemList]{
        var data: [ItemList] = []
        
        do{
            let misDatosLeidos = try Data(contentsOf: pathToFile(fileName: JSONFile))
            
            data = try JSONSerialization.jsonObject(with: misDatosLeidos) as! [ItemList] ?? []
        }catch _ {
            print("Error fatal de lectura. Sin datos")
        }
        
        return data
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return colorArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            colorSeleccionado = colorArray[row]
            colorPreview.tintColor = allColors[colorArray[row]]
        }
    }
    
    struct ItemList: Codable{
        var itemName: String
        var itemColorInHex: String
    }
    
}

extension UIColor {
    var hexString: String {
        let color = self.cgColor.components!
        let r = color[0]
        let g = color[1]
        let b = color[2]
        let a = color[3]

        return String(
            format: "#%02lX%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255)),
            lroundf(Float(a * 255))
        )
    }
}
