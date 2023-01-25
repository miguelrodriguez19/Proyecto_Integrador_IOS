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
    
    typealias myItem = [String: Any]
    typealias diccionarioItems = [String:myItem]
    
    let JSONFile = "listOfItems.json"
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
    
    @IBAction func addItem(_ sender: Any) {
        // Crea y añade una celda a la lista de la pantalla anterior
        let cellInfo = txtName.text ?? ""
        let cellColor = colorSeleccionado
        if cellInfo != "" {
            let myNewItem : diccionarioItems = ["producto": ["name": cellInfo, "color":cellColor]]
            addItemToJSON(itemList: myNewItem)
            
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
    
    func addItemToJSON(itemList: diccionarioItems)
    {
        let newArray = [itemList]
        if (readContentJSON().isEmpty){
            saveJSON(arrayToSave: newArray)
        }else{
            let finalArray = readContentJSON() + newArray
            saveJSON(arrayToSave: finalArray)
        }
    }
    
    func saveJSON(arrayToSave: [diccionarioItems]){
        do{
            let misDatoserializados = try JSONSerialization.data(withJSONObject: arrayToSave)
            try misDatoserializados.write(to: pathToFile(fileName: JSONFile))
        }catch _ {
                print("Error guardando el archivo")
        }
    }
    
    func readContentJSON() -> [diccionarioItems] {
        var data: [diccionarioItems] = []
        
        do{
            let misDatosLeidos = try Data(contentsOf: pathToFile(fileName: JSONFile))
            
            data = try JSONSerialization.jsonObject(with: misDatosLeidos) as! [diccionarioItems] ?? []
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
}

