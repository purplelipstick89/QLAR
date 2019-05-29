//
//  Opções.swift
//  QLAR
//
//  Created by Lary Tertuliano on 15/05/19.
//  Copyright © 2019 Lary Tertuliano. All rights reserved.
//

import Foundation

struct Escolha {
    var imagem: String
    var descricao : String
}

class Pergunta {
    internal init(escolhas: [Escolha], perguntaLabel: String) {
        self.escolhas = escolhas
        self.perguntaLabel = perguntaLabel
    }
    
    var escolhas: [Escolha]
    var perguntaLabel : String
    
}
