//
//  PredictTableViewController.swift
//  Breast Cancer Diagonsis
//
//  Created by Aniruddha Murali on 12/28/17.
//  Copyright © 2017 Aniruddha Murali. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class PredictTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var textureTextfField: UITextField!
    @IBOutlet weak var perimeterTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var smoothnessTextField: UITextField!
    @IBOutlet weak var compactnessTextField: UITextField!
    @IBOutlet weak var concavityTextField: UITextField!
    @IBOutlet weak var concavePointsTextField: UITextField!
    @IBOutlet weak var symmetryTextField: UITextField!
    @IBOutlet weak var fractalDimension: UITextField!
    var predictionViewController:PredictionViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        radiusTextField.delegate = self
        textureTextfField.delegate = self
        perimeterTextField.delegate = self
        areaTextField.delegate = self
        smoothnessTextField.delegate = self
        compactnessTextField.delegate = self
        concavityTextField.delegate = self
        concavePointsTextField.delegate = self
        symmetryTextField.delegate = self
        fractalDimension.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func resetButtonClicked(_ sender: Any) {
        radiusTextField.text = "17.99"
        textureTextfField.text = "10.38"
        perimeterTextField.text = "122.8"
        areaTextField.text = "1001"
        smoothnessTextField.text = "0.1184"
        compactnessTextField.text = "0.2776"
        concavityTextField.text = "0.3001"
        concavePointsTextField.text = "0.1471"
        symmetryTextField.text = "0.2419"
        fractalDimension.text = "0.07871"
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        //print("Raduis:\(radiusTextField.text ?? "")")
        
        let dict = ["radius":radiusTextField.text!,
                    "texture":textureTextfField.text!,
                    "perimeter":perimeterTextField.text!,
                    "area":areaTextField.text!,
                    "smoothness":smoothnessTextField.text!,
                    "compactness":compactnessTextField.text!,
                    "concavity":concavityTextField.text!,
                    "concavePoints":concavePointsTextField.text!,
                    "symmetry":symmetryTextField.text!,
                    "fractalDimension":fractalDimension.text!] as [String : Any]?
        //let json = JSON(dict)
        //let representation = json.rawString([.castNilToNSNull: true])
        //print(representation)
        
        //let urlString = "http://127.0.0.1:5000/predict?"
        let urlString = "https://buildnextai.herokuapp.com/predict?"
            + "radius=" + radiusTextField.text!
            + "&texture=" + textureTextfField.text!
            + "&perimeter=" + perimeterTextField.text!
            + "&area=" + areaTextField.text!
            + "&smoothness=" + smoothnessTextField.text!
            + "&compactness=" + compactnessTextField.text!
            + "&concavity=" + concavityTextField.text!
            + "&cp=" + concavePointsTextField.text!
            + "&symmetry=" + symmetryTextField.text!
            + "&fd=" + fractalDimension.text!
      
        print (urlString)
        
        //Alamofire.request(urlString, method: .get, parameters: dict!, encoding: JSONEncoding.default)
        Alamofire.request(urlString, method: .get)
            .responseJSON { response in
                
                print (request)
                print (response)
                switch response.result {
                case .success:
                    guard let responseVal = response.result.value else{
                        return
                    }
                    print (responseVal)
                    let responseJson = JSON(responseVal)
                    let prediction = responseJson["prediction"].string ?? ""
                    let accuracy = responseJson["accuracy"].string ?? ""
                    print(prediction)
                    print (accuracy)
                    self.predictionViewController?.setLabels(prediction: prediction, accuracy: accuracy)
                    self.predictionViewController?.animateActivityLoader(animate: false)
                    break
                case .failure( _):
                    //default
                    self.predictionViewController?.setLabels(prediction: "BENIGN", accuracy: "0")
                    self.predictionViewController?.animateActivityLoader(animate: false)
                    break
                    
                }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        predictionViewController = segue.destination as? PredictionViewController
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 11
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
