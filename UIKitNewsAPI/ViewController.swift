//
//  ViewController.swift
//  UIKitNewsAPI
//
//  Created by Akin on 16/08/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    
// create an array that will house the values we would need in the cells of our table, namely the two variables, webTitle and webUrl variables.
    var guardianNews = [Guardian]()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Tap on any news below".uppercased()
       
        
        
        let url = URL(string: "https://content.guardianapis.com/search?api-key=21b7bbb2-7987-4ef2-bfab-ec61018fa736")
        
    guard url != nil else {
            return
        }
        
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil && data != nil {
                
                // now Ill be ruuning code on the main thread by using DispatchQeue.main.async
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    
                    do {
                        let guardParsed = try decoder.decode(GuardianResponse.self, from: data!)
                        self.guardianNews = (guardParsed.response?.results)!
                        self.tableView.reloadData()
                        
                        
                    } catch  {
                       // print("error")
                        self.makeError()
                    }
                    
                }
                
 
                
            }
        }
        task.resume()
            
            
        
    }
    
    // here i created an alertcontoller that will serve and display the error messages.
    func makeError(){
        let ac = UIAlertController(title: "Error", message: "JSON Codable Error", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(ac, animated: true, completion: nil)
        
    }
    
    
    
    // create function that will determine how many rows we would have in our table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guardianNews.count
    }
    
    
    
    

    
    
    // I will populate the cells in the table from the contents of our array
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let theGuardian = guardianNews[indexPath.row]
        cell.textLabel?.text = theGuardian.webTitle
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        cell.textLabel?.numberOfLines = 0
    //    cell.textLabel?.font = [UIFont: SystemFontOfSize:12.0]
        cell.detailTextLabel?.text = theGuardian.webUrl
        return cell
    }
    
    
    
    
    // here i have used the didselectrowat function to display another view controller that will create from code. This new view controller is the DetailViewController that will display the web content when this table cell is clicked.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // I created the DetailViewController by code here
        let dvc = DetailViewController()
        dvc.selectedItem = guardianNews[indexPath.row]
        navigationController?.pushViewController(dvc, animated: true)
        
    }
    



}



