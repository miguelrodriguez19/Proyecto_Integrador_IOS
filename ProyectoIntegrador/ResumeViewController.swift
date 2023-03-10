//
//  ResumeViewController.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 2/11/22.
//

import UIKit

class ResumeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var collectionView2: UICollectionView!
    
    
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
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let celdaListas = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell2{
            celdaListas.configure(with: dataSource[indexPath.row]["tittle"]!, content: dataSource[indexPath.row]["content"]!)
            cell = celdaListas
        }
        return cell
    }
    
    //Funcion que se utiliza para pasar el titulo de la celda seleccionada al viewController"ListasViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
}

class CollectionViewCell2: UICollectionViewCell {
    
    
    @IBOutlet weak var infoListas: UITextView!
    @IBOutlet weak var labelListas: UILabel!
    
    func configure(with nombreListas: String, content:String){
        labelListas.text = nombreListas
        infoListas.text = content
    }
    
}
   
    extension ResumeViewController: UICollectionViewDelegateFlowLayout {
        
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
    


