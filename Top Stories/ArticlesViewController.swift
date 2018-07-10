//
//  ViewController.swift
//  Top Stories
//
//  Created by Aslan Lee on 7/10/18.
//  Copyright © 2018 Aslan Lee. All rights reserved.
//

import UIKit

class ArticlesViewController: UITableViewController {
    
    var cards = [[String: String]]()
    var nameKey = ""
    var source = [String: String]()
    var query : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemon TCG"
        DispatchQueue.global(qos: .userInitiated) .async {
            [unowned self] in
            if let url = URL(string: self.query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let article = cards[indexPath.row]
        cell.textLabel?.text = article["name"]
        cell.detailTextLabel?.text = article["imageUrl"]
        return cell
    }
    
    func parse(json: JSON){
        for result in json["cards"].arrayValue {
            let hp = result["hp"].stringValue
            let name = result["name"].stringValue
            let imageURL = result["imageUrl"].stringValue
            let source = ["hp": hp, "name": name, "imageUrl": imageURL]
            cards.append(source)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: cards[indexPath.row]["imageUrl"]!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
}

