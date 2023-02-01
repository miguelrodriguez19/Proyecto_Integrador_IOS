//
//  ResumeViewController.swift
//  ProyectoIntegrador
//
//  Created by Miguel Rodríguez Herrero on 2/11/22.
//

import UIKit

class ResumeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var collectionView: UICollectionView!
    
    
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 30.0,
        bottom: 100.0,
        right: 30.0)
    
    private var itemsPerRow: CGFloat = 2
    
    let dataSource: [String] = ["Lista 1", "Lista 2", "Lista 3", "Lista  4", "Lista 5", "Lista 6"]
    var selectedList: String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let celdaListas = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell{
            celdaListas.configure(with: dataSource[indexPath.row])
            cell = celdaListas
        }
        return cell
    }
    
    //Funcion que se utiliza para pasar el titulo de la celda seleccionada al viewController"ListasViewController
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Asignamos a selected lis la lista seleccionada
        selectedList = dataSource[indexPath.item]
        //Asignamos miVista al ViewController ListasViewController que le hemos puesto ese id
        let miVista = storyboard?.instantiateViewController(withIdentifier: "listasController") as! ListasViewController
        //Asignamos a la variable intercambio el valor de la celda seleccionada
        miVista.intercambio = selectedList
        //Envio a la otra pantalla
        self.navigationController?.pushViewController(miVista, animated: true)
        print(selectedList)
        
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
    


