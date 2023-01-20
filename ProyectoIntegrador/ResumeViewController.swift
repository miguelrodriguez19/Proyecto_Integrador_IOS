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
        top: 10.0,
        left: 25.0,
        bottom: 100.0,
        right: 20.0)
    
    private var itemsPerRow: CGFloat = 2
    
    let dataSource: [String] = ["Lista 1", "Lista 2", "Lista 3", "Lista  4", "Lista 5", "Lista 6"]
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedList: String = dataSource[indexPath.item]
        
      //  performSegue(withIdentifier: "showDetail", sender: selectedList)
        print(selectedList)
        let destino = ListasViewController()
        destino.intercambio = selectedList

        
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let destino = segue.destination as! ListasViewController; destino.intercambio = textToPass!
        }
    }*/
    

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

