//
//  ResultadosViewController.swift
//  QLAR
//
//  Created by Lary Tertuliano on 15/05/19.
//  Copyright © 2019 Lary Tertuliano. All rights reserved.
//

import UIKit

class ResultadosViewController: UIViewController {

    
    let resultados: [String] = ["Abacaxi", "Casa do Lago", "Dentro de um jogo", "Barraca", "cobertura de chocolate", "No fundo do oceano"]
    
    @IBOutlet weak var resultadoImage: UIImageView!
    
    var respostaCerta: QuizzResult!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "Resultado\((respostaCerta.rawValue + 1))")
        resultadoImage.image = image
    }
    
    @IBAction func finalizar(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
