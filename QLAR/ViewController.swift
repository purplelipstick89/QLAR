//
//  ViewController.swift
//  QLAR
//
//  Created by Lary Tertuliano on 11/05/19.
//  Copyright © 2019 Lary Tertuliano. All rights reserved.
//

import UIKit

enum QuizzResult: Int {
    case abacaxi = 0
    case lago
    case jogo
    case barraca
    case cobertura
    case oceano
    case again
}

class ViewController: UIViewController {
    
    @IBOutlet weak var perguntaLabel: UILabel!
    @IBOutlet weak var passosLabel: UILabel!
    @IBOutlet weak var option1Image: UIImageView!
    @IBOutlet weak var option2Image: UIImageView!
    @IBOutlet weak var option3Image: UIImageView!
    @IBOutlet weak var option4Image: UIImageView!
    @IBOutlet weak var option5Image: UIImageView!
    @IBOutlet weak var option6Image: UIImageView!
  
    var respostas : [Int] = []
   
    var perguntaAtual = 0
    
    var allQuestions : [Pergunta] = []
    
    //Abacaxi", "Casa do Lago", "Dentro de um jogo", "Barraca", "cobertura de chocolate", "No fundo do oceano"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pergunta1 = Pergunta(escolhas: [Escolha(imagem: "Cor1", descricao: "Verde Chimarrão"), Escolha(imagem: "Cor2", descricao: "Branco Espuma"), Escolha(imagem: "Cor3", descricao: "Amarelo Sol"), Escolha(imagem: "Cor4", descricao: "Laranja Mecânica"), Escolha(imagem: "Cor5", descricao:  "Azul Cinderela"), Escolha(imagem: "Cor6", descricao: "Preto Buraco Negro")], perguntaLabel: "Pick a Color:")
        
        let pergunta2 = Pergunta(escolhas: [Escolha(imagem: "Comida1", descricao: "Verde Chimarrão"), Escolha(imagem: "Comida2", descricao: "Branco Espuma"), Escolha(imagem: "Comida3", descricao: "Amarelo Sol"), Escolha(imagem: "Comida4", descricao: "Laranja Mecânica"), Escolha(imagem: "Comida5", descricao:  "Azul Cinderela"), Escolha(imagem: "Comida6", descricao: "Preto Buraco Negro")], perguntaLabel: "Pick a food:")
        
        let pergunta3 = Pergunta(escolhas: [Escolha(imagem: "Atividade1", descricao: "Verde Chimarrão"), Escolha(imagem: "Atividade2", descricao: "Branco Espuma"), Escolha(imagem: "Atividade3", descricao: "Amarelo Sol"), Escolha(imagem: "Atividade4", descricao: "Laranja Mecânica"), Escolha(imagem: "Atividade5", descricao:  "Azul Cinderela"), Escolha(imagem: "Atividade6", descricao: "Preto Buraco Negro")], perguntaLabel: "Pick an Activity:")
        
        allQuestions = [pergunta1, pergunta2, pergunta3]
        
        self.updatePage()
        self.setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        perguntaAtual = 0
        respostas.removeAll()
        updatePage()
    }
    
    func setupGestures() {
        
        option1Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        option1Image.tag = 0
        option2Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        option2Image.tag = 1
        option3Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        option3Image.tag = 2
        option4Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        option4Image.tag = 3
        option5Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        option5Image.tag = 4
        option6Image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
        option6Image.tag = 5
    }
    
    @objc func imageTapped(_ recognizer: UITapGestureRecognizer) {
        if let tag = recognizer.view?.tag {
            respostas.append(tag)
            perguntaAtual += 1
            updatePage()
        }
    }

    func updatePage() {
        if perguntaAtual < allQuestions.count {
            
            let pergunta = allQuestions[perguntaAtual]
            
            perguntaLabel.text = pergunta.perguntaLabel
            
            passosLabel.text = "\(perguntaAtual+1)/\(allQuestions.count)"
           
            option1Image.image = UIImage(named: pergunta.escolhas[0].imagem)
            option2Image.image = UIImage(named: pergunta.escolhas[1].imagem)
            option3Image.image = UIImage(named: pergunta.escolhas[2].imagem)
            option4Image.image = UIImage(named: pergunta.escolhas[3].imagem)
            option5Image.image = UIImage(named: pergunta.escolhas[4].imagem)
            option6Image.image = UIImage(named: pergunta.escolhas[5].imagem)
        } else {
            let result = contaRespostas()
            print(result)
            if result == .again {
                performSegue(withIdentifier: "again", sender: nil)
             } else {
                performSegue(withIdentifier: "resultado", sender: result)
            }
        }
    }
    
    func contaRespostas() -> QuizzResult {
        var contador: [Int] = [0, 0, 0, 0, 0, 0]
        
        for item in respostas {
            contador[item] += 1
        }
        
        let maiorValor = contador.sorted().last!
        if maiorValor == 1 {
            return .again
        }
        
        for (indice, incidencia) in contador.enumerated(){
            if incidencia == maiorValor{
                return QuizzResult(rawValue: indice) ?? .again
            }
            
        }
        return .again
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "again"{
            let vc = segue.destination as! AgainViewController
            vc.again = UIImage(named: "Comida1")
        }else{
            let result = (sender as! QuizzResult)
            let dest = segue.destination as! ResultadosViewController
            dest.respostaCerta = result
        }
    }
}
