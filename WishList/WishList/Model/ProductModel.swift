//
//  ProductModel.swift
//  WishList
//
//  Created by Sam.Lee on 4/9/24.
//

import Foundation

protocol ProductModelDelegate {
    func dataRetrieved(product : Product)
}

class ProductModel{
    var delegate : ProductModelDelegate?
    let urlString = "https://dummyjson.com/products/"
    
    func getProductsURLSession(){
        let randomID = Int.random(in: 1...100)
        if let url = URL(string: urlString+String(randomID)) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                }else if let data = data {
                    do {
                        let product = try JSONDecoder().decode(Product.self, from: data)
                        DispatchQueue.main.async {
                            self.delegate?.dataRetrieved(product: product)
                        }
                    }catch{
                        print("Decode Error \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    //    func getProductAlamofire (){
    //        let randomID = Int.random(in: 1...100)
    //
    //        if let url = URL(string: urlString+String(randomID)) {
    //            AF.request(url).response {response in
    //                switch response.result {
    //                case .success(let data):
    //                    do{
    //                        let product = try JSONDecoder().decode(Product.self, from: data!)
    //                        DispatchQueue.main.async {
    //                            self.delegate?.dataRetrieved(product: product)
    //                        }
    //                    }catch{
    //                        print("Decode Error \(error)")
    //                    }
    //                case .failure(let error):
    //                    print(error)
    //                }
    //            }
    //        }
    //    }
    
}
