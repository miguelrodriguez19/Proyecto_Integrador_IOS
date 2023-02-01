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
    let dataSource: [[String:String]] = [["tittle":"Lista 1", "content":"asdfghjklñ"],["tittle":"Lista 2", "content":"a75ug67hfg6ylñ"],["tittle":"Lista 3", "content":"a56g7u8jk85kfghjklñ"],["tittle":"Lista 4", "content":"asg89l9l0'ñlp"],]
  //  let dataSource2: [String] = []
    var selectedList: String = ""
    var selectedContent: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.miColectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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
            celdaListas.configure(with: dataSource[indexPath.row]["tittle"]!, content: dataSource[indexPath.row]["content"]!)
            cell = celdaListas
        }
        return cell
    }

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Asignamos a selected lis la lista seleccionada
        selectedList = dataSource[indexPath.item]["tittle"]!
        selectedContent = dataSource[indexPath.item]["content"]!
        //Asignamos miVista al ViewController ListasViewController que le hemos puesto ese id
        let miVista = storyboard?.instantiateViewController(withIdentifier: "listasController") as! ListasViewController
        //Asignamos a la variable intercambio el valor de la celda seleccionada
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
    


