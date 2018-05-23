//
//  PokemonController.swift
//  PokemonSearch
//
//  Created by Thao Doan on 5/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import Foundation
import UIKit

class PokemonController  {
    
    
    static let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")
    
    static  func fetchPokemonWith(idOrName: String, completion: @escaping ((Pokemon?) -> Void)) {
        
        //URL + test URL
        
        guard var url = baseUrl else {completion (nil); return}
        
        url.appendPathComponent(idOrName)
        print("\(url.absoluteString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        //  URLSessionDataTask + Resume + Decode
        URLSession.shared.dataTask(with: request) { (data, _ , error) in
    
            if let error = error {
                print("Error downloading pokemon with DataTask: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {completion(nil); return}
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                
                completion(pokemon)
                
                
            } catch let error {
                
                print("Error decoding pokemon from data task: \(error.localizedDescription)")
                
                completion(nil)
                
                return
            }
            
            }.resume()
    }
    
    static func fetchImage(withUrl : String, completion: @escaping ((UIImage?) -> Void)) {
        //URL
        guard let url = URL(string: withUrl) else {completion(nil) ;return }
        //Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        // DataTask + Resume + Decode 
        let session =  URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print ("\(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data ,
                let image = UIImage(data: data) else {completion(nil) ; return }
            completion(image)
        };session.resume()
    }
}


