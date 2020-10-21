//
//  ViewController.swift
//  ShahbazKhanTest
//
//  Created by admin on 10/21/20.
//  Copyright © 2020 DemoApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData()
    {
        viewModel.getDataFromAPIHandlerClass()
    }


}

