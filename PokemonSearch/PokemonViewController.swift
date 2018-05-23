//
//  PokemonViewController.swift
//  PokemonSearch
//
//  Created by Thao Doan on 5/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      searchBar.delegate = self 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var idLabel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PokemonViewController : UISearchBarDelegate {
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
           searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text?.lowercased() else {return}
        
        PokemonController.fetchPokemonWith(idOrName: searchText) { (pokemon) in
            
            guard let pokemon = pokemon else {return}
            
            DispatchQueue.main.async {
                self.nameLabel.text = "Name: \(pokemon.name)"
                self.weightLabel.text = "Weight: \(pokemon.weight)"
                self.idLabel.text = "Id:\(pokemon.id)"
            }
            PokemonController.fetchImage(withUrl: pokemon.sprites.spriteImage, completion: { (image) in
                guard let image = image else {return}
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            })
            
        }
        
        searchBar.text = "" 
    }
}
