//
//  PredictionViewController.swift
//  Breast Cancer Diagonsis
//
//  @author Aniruddha Murali
//  Copyright © 2017 Aniruddha Murali. All rights reserved.
//

import UIKit

class PredictionViewController: UIViewController {
    
    @IBOutlet weak var predictionLabel: UILabel!
    
    @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!
    @IBOutlet weak var accuracyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setLabels(prediction: String, accuracy: String) {
        predictionLabel.text = prediction
        accuracyLabel.text = "\(accuracy)%"
    }
    
    
    func animateActivityLoader(animate:Bool) {
        if(animate){
            self.loadingActivityView.startAnimating()
        }else{
            self.loadingActivityView.stopAnimating()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
