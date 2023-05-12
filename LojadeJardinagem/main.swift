//
//  main.swift
//  LojadeJardinagem
//
//  Created by user on 28/03/23.
//

import Foundation

// iniciar loja
var dict_prod = [Int: Array<String>]()
dict_prod[0] = ["Semente de girassol", "123", "0.50", "semente"]
dict_prod[1] = ["Palmeira", "345", "125.90", "planta"]
dict_prod[2] = ["To legal", "678", "2.50", "adubo"]
dict_prod[3] = ["Cresce rápido", "654", "4.80", "fertilizante"]
dict_prod[4] = ["Vai", "876", "4.80", "fertilizante"]
dict_prod[5] = ["Cresce muito muito rápido", "358", "4.80", "fertilizante"]

var carrinho = [Int: Int]()
var controle = "2"

repeat {
    
    print("Bem-vindo a loja Adube-se. Aqui temos produtos para todos os tipos de plantas.")
    print("1. Listar todos os produtos")
    print("2. Buscar produto por categoria")
    print("3. Adicionar produto ao carrinho")
    print("4. Ver carrinho")
    print("9. Encerrar")
    
    print("")
    print("O que voce deseja fazer? Digite o numero correspondente")
    
    let input = readLine() ?? ""
    
    
    print("")
    
    // Encerrar sistema
    switch input{
    case "1":
        listarProdutos()
    case "2":
        mostrarCategoria()
    case "3":
        addcarrinho()
        
    case "4":
        mostrarcarrinho()
    case "9":
        controle = "1"
    default:
        print("Opcao invalida")
    }
    
    if controle != "1" {                            //nao esta funcionando. o loop reinicia independente do numero escolhido, 9 encerra.
        print("")
        print("0. Voltar ao menu anterior")
        // print("3. Adicionar produtos ao carrinho")
        // print("4. Mostrar carrinho")
        print("9. Encerrar programa")
        
        
        let input2 = readLine()
        /*if(input2 == "3") {
         addcarrinho()
         }
         
         if(input2 == "4") {
         mostrarcarrinho()
         }*/
        
        if (input2 == "9") {
            controle = "1"
        }
        
        
    }
    
} while (controle != "1")

func listarProdutos (){
    var lid = 0
    var lnome = 0
    var lpreco = 0
    var lcategoria = 0
    
    for (_, prod) in dict_prod {
        if (prod[0]).count > lnome {lnome = (prod[0]).count}
        if (prod[1]).count > lid {lid = (prod[1]).count}
        if (prod[2]).count > lpreco {lpreco = (prod[2]).count}
        if (prod[3]).count > lcategoria {lcategoria = (prod[3]).count}
    }
    
    var somatotal = (((lid+lnome)+lpreco)+lcategoria)
    print("Listagem completa de produtos:")
    print((String(repeating: "-", count: somatotal+13)))
    
    print("| ID \(repete(caractere: " ", Qtd: (lid-2)))| Produto \(repete(caractere: " ", Qtd: (lnome-7)))| Preco \(repete(caractere: " ", Qtd: (lpreco-5)))| Categoria \(repete(caractere: " ", Qtd: (lcategoria-9)))|")
    print((String(repeating: "-", count: somatotal+13)))
    
    for (_, prod) in dict_prod {
        print(("| \(prod[1]) \(repete(caractere: " ", Qtd: lid-(prod[1]).count))| \(prod[0])\(repete(caractere: " ", Qtd: lnome-(prod[0]).count)) | \(prod[2])\(repete(caractere: " ", Qtd: lpreco-(prod[2]).count)) | \(prod[3])\(repete(caractere: " ", Qtd: lcategoria-(prod[3]).count)) |"))
    }
    print((String(repeating: "-", count: somatotal+13)))
}

func repete(caractere : String, Qtd : Int) -> String {
    return String(repeating: caractere, count: Qtd)
}

func addcarrinho(){
    
    listarProdutos()
    
    print("")
    print("Adicionar produto ao carrinho")
    print("Digite o ID do produto:")
    if let id = Int(readLine() ?? "") {
        
        var produtoencontrado = 0
        
        for (i, prod) in dict_prod {
            
            if prod[1] == String(id) {
                produtoencontrado = i
            }
        }
        
        if dict_prod[produtoencontrado] != nil {
            print("Digite a quantidade:")
            if let qtd = Int(readLine() ?? "") {
                if qtd > 0 {
                    if carrinho[produtoencontrado] != nil {
                        carrinho[produtoencontrado]! += qtd
                    } else {
                        carrinho[produtoencontrado] = qtd
                    }
                    print("\(qtd) unidades do produto \(dict_prod[produtoencontrado]![0]) adicionadas ao carrinho.")
                } else {
                    print("Quantidade inválida. Tente novamente.")
                }
            } else {
                print("Quantidade inválida. Tente novamente.")
            }
        } else {
            print("Produto não encontrado. Tente novamente.")
        }
    } else {
        print("ID inválido. Tente novamente.")
    }
}

func mostrarcarrinho(){
    if carrinho.isEmpty {
        print("Carrinho vazio.")
    } else {
        print("Itens no carrinho:")
        print("---------------------------------------------------------------")
        print("|             Nome             |            Preço       | Qtd | Valor Total |")
        print("---------------------------------------------------------------")
        for (id, qtd) in carrinho {
            let prod = dict_prod[id]!
            let nome = prod[0]
            let preco = prod[2]
            var precoint = Float(prod[2]) ?? 0
            var valor = precoint * Float(qtd)
            var valorTotal = String(format: "%.2f", valor)
            print("|", nome.padding(toLength: 28, withPad: " ", startingAt: 0), "|", preco.padding(toLength: 22, withPad: " ", startingAt: 0), "| \(qtd)   |", "| \(valorTotal)  |")
            print("---------------------------------------------------------------")
        }
    }
}

func mostrarCategoria(){
    print("Digite o número da categoria que voce deseja visualizar os produtos.")
    print("1. Adubo")
    print("2. Fertilizante")
    print("3. Planta")
    print("4. Semente")
    let categ = readLine()
    switch categ{
    case "1":
        mostrarProdCateg(categoria: "adubo")
    case "2":
        mostrarProdCateg(categoria: "fertilizante")
    case "3":
        mostrarProdCateg(categoria: "planta")
    case "4":
        mostrarProdCateg(categoria: "semente")
    default:
        print("Categoria invalida. Tente novamente.")
        
    }
    
}

func mostrarProdCateg(categoria: String){
    var lid = 0
    var lnome = 0
    var lpreco = 0
    var lcategoria = 0
    
    for (_, prod) in dict_prod {
        if (prod[0]).count > lnome {lnome = (prod[0]).count}
        if (prod[1]).count > lid {lid = (prod[1]).count}
        if (prod[2]).count > lpreco {lpreco = (prod[2]).count}
        if (prod[3]).count > lcategoria {lcategoria = (prod[3]).count}
    }
    print("Listagem completa de produtos da categoria \(categoria):")
    var somatotal = (((lid+lnome)+lpreco)+lcategoria)
    print((String(repeating: "-", count: somatotal+13)))
    print("| ID \(repete(caractere: " ", Qtd: (lid-2)))| Produto \(repete(caractere: " ", Qtd: (lnome-7)))| Preco \(repete(caractere: " ", Qtd: (lpreco-5)))| Categoria \(repete(caractere: " ", Qtd: (lcategoria-9)))|")
    print((String(repeating: "-", count: somatotal+13)))
    
    
    for (_, prod) in dict_prod {
        if(prod[3]==categoria){
            print(("| \(prod[1]) \(repete(caractere: " ", Qtd: lid-(prod[1]).count))| \(prod[0])\(repete(caractere: " ", Qtd: lnome-(prod[0]).count)) | \(prod[2])\(repete(caractere: " ", Qtd: lpreco-(prod[2]).count)) | \(prod[3])\(repete(caractere: " ", Qtd: lcategoria-(prod[3]).count)) |"))
        }}
    print((String(repeating: "-", count: somatotal+13)))
    
    
}




