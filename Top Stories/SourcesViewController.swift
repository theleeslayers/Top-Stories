//
//  ViewController.swift
//  Top Stories
//
//  Created by Aslan Lee on 7/10/18.
//  Copyright © 2018 Aslan Lee. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController{

    @IBAction func onTappedDoneButton(_ sender: Any) {
        exit(0)
    }
    //var sources = [[String: String]]()
    var pokemonTypes = [String]()
    var nameKey = "pikachu"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemon Cards"
        
        pokemonTypes.append("pikachu")
        pokemonTypes.append("charizard")
        pokemonTypes.append("squirtle")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let source = pokemonTypes[indexPath.row]
        //cell.textLabel?.text = source["name"]
        //cell.detailTextLabel?.text = source["description"]
        cell.textLabel?.text = source
        return cell
        
    }

    /*func parse(json: JSON){
        for result in json["cards"].arrayValue {
            print(result)
            let hp = result["hp"].stringValue
            let name = result["name"].stringValue
            let imageURL = result["imageUrl"].stringValue
            let source = ["hp": hp, "name": name, "imageUrl": imageURL]
            sources.append(source)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }*/

    func loadError() {
        DispatchQueue.main.async {
            [unowned self] in
        let alert = UIAlertController(title: "Loading Error",
                                      message: "There was a problem loading the feed",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! ArticlesViewController
        let index = tableView.indexPathForSelectedRow?.row
        nameKey = pokemonTypes[index!]
        dvc.query = "https://api.pokemontcg.io/v1/cards?name=\(nameKey)"
    }
}

