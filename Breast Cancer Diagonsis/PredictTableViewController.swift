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

class PredictTableViewController: UITableViewController {

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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func submitButtonClicked(_ sender: Any) {
        //print("Raduis:\(radiusTextField.text ?? "")")
        
        let dict = ["raduis":radiusTextField.text!,
                    "texture":textureTextfField.text!,
                    "perimeter":perimeterTextField.text!,
                    "area":areaTextField.text!,
                    "smoothness":smoothnessTextField.text!,
                    "compactness":compactnessTextField.text!,
                    "concavity":concavityTextField.text!,
                    "concavePoints":concavePointsTextField.text!,
                    "symmetry":symmetryTextField.text!,
                    "fractalDimension":fractalDimension.text!] as [String : Any]?
        let json = JSON(dict)
        let representation = json.rawString([.castNilToNSNull: true])
        //print(representation)
        
        let urlString = "http://127.0.0.1:5000/predict"
        
        //MURALI CODE START
        //let urlString = "http://127.0.0.1:5000/predict?radius=13.08&texture=15.71&perimeter=85.63&area=520&smoothness=0.1075&compactness=0.127&concavity=0.04568&cp=0.0311&symmetry=0.1967&fd=0.06811"
        
/*
        var urlComponents = URLComponents(string: "http://127.0.0.1:5000/predict")!
        urlComponents.queryItems = [
            URLQueryItem(name: "radius", value: String(51.500833)+","+String(-0.141944)),
            URLQueryItem(name: "z", value: String(6))
        ]
        urlComponents.url      // returns https://www.google.de/maps/?q=51.500833,-0.141944&z=6
        */
        
      
        //print (urlString)
        
        //MURALI CODE EMD
        Alamofire.request(urlString, method: .get, parameters: dict!, encoding: JSONEncoding.default)
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
                    break
                case .failure( _):
                    //for testing
                    self.predictionViewController?.setLabels(prediction: "Benign", accuracy: "93")
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
