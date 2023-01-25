//
//  CollectionViewCell.swift
//  ProyectoIntegrador
//
//  Created by Ignacio Moreno Fernández on 19/1/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var labelListas: UILabel!
    
    func configure(with nombreListas: String){
        labelListas.text = nombreListas
    }
    
}
