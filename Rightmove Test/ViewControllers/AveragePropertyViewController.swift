//
//  ViewController.swift
//  Rightmove Test
//
//  Created by Shyam Bhudia on 09/07/2020.
//  Copyright © 2020 Shyam Bhudia. All rights reserved.
//

import UIKit

class AveragePropertyViewController: UIViewController, AveragePropertyDelegate {

    var viewModel: AveragePropertyViewModel?
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = AveragePropertyViewModel(delegate: self)
    }

    func didReceiveData() {
        guard let answer = viewModel?.averagePropertyPrices else { return }
        answerLabel.text = "Answer: \(answer)"
    }
    
    func didError(with error: APIError) {
        let alert = UIAlertController(title: "Sorry, Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
        self.present(alert, animated: true) { [weak self] in
            self?.answerLabel.text = "Answer: "
        }
    }
    
    
}
