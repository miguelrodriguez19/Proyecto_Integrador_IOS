//
//  ResumeCollectionViewController.swift
//  ProyectoIntegrador
//
//  Created by Ignacio Moreno Fernández on 1/2/23.
//

import UIKit

private let reuseIdentifier = "Cell"

class ResumeCollectionViewController: UICollectionViewController {

    
    
    @IBOutlet var miColectionView: UICollectionView!
   // var miCole:cion UICollectionView!
    
    
  /*  private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 10.0,
        bottom: 100.0,
        right: 20.0)*/
    
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)

    
    private var itemsPerRow: CGFloat = 2
    
    //let dataSource: [String] = ["Lista 1", "Lista 2", "Lista 3", "Lista  4", "Lista 5", "Lista 6"]
    var dataSource: [Note] = [Note]()
  //  let dataSource2: [String] = []
    var selectedList: String = ""
    var selectedContent: String = ""
    var selectedNote: Note? = nil
    typealias typeUser = [String:String]
    var currentUser = typeUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = UserDefaults.standard.object(forKey: Config.shared.currentUser) as! [String:String]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        currentUser = UserDefaults.standard.object(forKey: Config.shared.currentUser) as! [String:String]
        
        
        
        // Register cell classes
        self.miColectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
        getNotes(id: "\(currentUser["cod_user"]!)")
        // Do any additional setup after loading the view.
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        getNotes(id: "\(currentUser["cod_user"]!)")
        self.miColectionView!.reloadData()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func getNotes(id: String) {
            let url = URL(string: "\(Config.shared.staticURL)notes/listByUser/\(id)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
    
        do{
            let miDecodificador = JSONDecoder()
            let misDatos = try Data(contentsOf: url)
            self.dataSource = try miDecodificador.decode([Note].self, from: misDatos)
        }
        catch{
            print("Erroraco al decodificar JSON")
        }
    }
/*
    func getNotes2(id: String) {
            let url = URL(string: "\(Config.shared.staticURL)notes/listByUser/\(id)")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                self.dataSource = try JSONDecoder().decode([Note].self, from: data)
                // use the notes array here
            } catch let error {
                print("Error decoding notes response: \(error)")
            }
        }
        task.resume()
        
    }
 */
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    //override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = miCollectionViewCell()
        
        if let celdaListas = miColectionView.dequeueReusableCell(withReuseIdentifier: "miCelda", for: indexPath) as? miCollectionViewCell{
            celdaListas.configure(with: dataSource[indexPath.row].tittle, content: dataSource[indexPath.row].content)
            cell = celdaListas
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Asignamos a selected lis la lista seleccionada
        selectedNote = dataSource[indexPath.item]
        selectedList = dataSource[indexPath.item].tittle
        selectedContent = dataSource[indexPath.item].content
        //Asignamos miVista al ViewController ListasViewController que le hemos puesto ese id
        let miVista = storyboard?.instantiateViewController(withIdentifier: "listasController") as! ListasViewController
        //Asignamos a la variable intercambio el valor de la celda seleccionada
        miVista.noteIntercambio = selectedNote
        miVista.intercambio = selectedList
        miVista.intercambioContent = selectedContent
        //Envio a la otra pantalla
        self.navigationController?.pushViewController(miVista, animated: true)
        print(selectedList)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
class miCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var infoListas: UITextView!
    @IBOutlet weak var labelListas: UILabel!
    
    func configure(with nombreListas: String, content:String){
        labelListas.text = nombreListas
        infoListas.text = content
    }
    
}
   
    extension ResumeCollectionViewController: UICollectionViewDelegateFlowLayout {
        
        // 1
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            sizeForItemAt indexPath: IndexPath
        ) -> CGSize {
            // 2
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            
            return CGSize(width: widthPerItem, height: widthPerItem)
        }
        
        // 3
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            insetForSectionAt section: Int
        ) -> UIEdgeInsets {
            return sectionInsets
        }
        
        // 4
        func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            minimumLineSpacingForSectionAt section: Int
        ) -> CGFloat {
            return sectionInsets.left
        }
    }
    


