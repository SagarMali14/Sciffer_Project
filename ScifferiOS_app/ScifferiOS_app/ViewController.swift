//
//  ViewController.swift
//  ScifferiOS_app
//
//  Created by Felix IT on 21/05/22.
//  Copyright © 2022 Felix IT. All rights reserved.
//

import UIKit

struct MovieData: Decodable {
    var Title: String
    var Rating: String
}

class ViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var movieArray: [MovieData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      dataJson()

    }
    
    func dataJson() {
        
        let url = URL(string: "https://f052e9ed-54d8-4b98-b64f-808bd17df254.mock.pstmn.io/get?data=1")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                self.movieArray = try JSONDecoder().decode([MovieData].self, from: data!)
                DispatchQueue.main.async {
                    self.myTableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = movieArray[indexPath.row].Title
        cell?.detailTextLabel?.text = movieArray[indexPath.row].Rating
        return cell!
    }
    
    
}

