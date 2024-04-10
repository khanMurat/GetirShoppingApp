//
//  ProductRepository.swift
//  GetirFinalCase
//
//  Created by Murat on 10.04.2024.
//

import Foundation
import SQLite

protocol ProductRepositoryProtocol {
    
}

final class ProductRepository {
    
    static let shared = ProductRepository()
    
    private var database : Connection!
    
    let productTable = Table("Product")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let imageURL = Expression<String>("imageURL")
    let price = Expression<Int>("price")
    let priceText = Expression<String>("priceText")
    let thumbnailURL = Expression<String>("thumbnailURL")
    let isInBasket = Expression<Bool>("isInBasket")
    let basketCount = Expression<Int>("basketCount")
    
    private init() {
        
        getDatabasePath()
        
    }
    
    private func getDatabasePath(){
        
        do{
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            
            self.database = try Connection("\(path)/db.sqlite3")
            
            createTable()
        }catch{
            print("DEBUG : Error when database connection \(error.localizedDescription)")
        }
    }
    
    private func createTable(){
        
        do{
            let existingTables = try database.scalar("SELECT name FROM sqlite_master WHERE type='table' AND name='Product'")
            if existingTables != nil{
                print("Table already exists")
                return
            }
        }catch{
            print("Error checking for existing table: \(error)")
        }
        
        do{
            try database.run(productTable.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(price)
                t.column(priceText)
                t.column(imageURL)
                t.column(thumbnailURL)
                t.column(isInBasket)
                t.column(basketCount)
            })
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
//    func insertWord(model:DatabaseModel){
//        
//        let insertOrUpdate = productTable.insert(or: .replace,
//                                               name <- model.name
//        )
//        do{
//            try database.run(insertOrUpdate)
//            print("Inserted word successfully.")
//        }catch{
//            print("DEBUG : Error when insert word to table \(error.localizedDescription)")
//        }
//    }
}
