//
//  SelectCurrencyController.swift
//  Chenge
//
//  Created by Aleksander Kulikov on 26.12.2020.
//

import UIKit

enum flagCurrencySelected {
    case from
    case to
}

class SelectCurrencyController: UITableViewController {
    
    
    @IBAction func cancelSelected(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var flagCurrency: flagCurrencySelected = .from

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 65
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ModelUA.shared.currencies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CoursesControllerCell
        
        let currentCurrency = ModelUA.shared.currencies[indexPath.row]
        cell.initCelll(currencye: currentCurrency)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency: Currencye = ModelUA.shared.currencies[indexPath.row]
        if flagCurrency == .from {
            ModelUA.shared.fromCurrency = selectedCurrency
        }
        
        if flagCurrency == .to {
            ModelUA.shared.toCurrency = selectedCurrency
        }
        
        dismiss(animated: true, completion: nil)
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
