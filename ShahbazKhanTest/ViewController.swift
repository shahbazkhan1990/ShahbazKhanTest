//
//  ViewController.swift
//  ShahbazKhanTest
//
//  Created by admin on 10/21/20.
//  Copyright © 2020 DemoApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var viewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.estimatedRowHeight = 500.0
        self.tblView.rowHeight = UITableView.automaticDimension

        getData()
    }
    
    func getData()
    {
        viewModel.getDataFromAPIHandlerClass()
    }


}

extension ViewController : UITableViewDataSource, UITableViewDelegate {

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
}

func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
{
 return 500
}

func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 70
}

func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 70))
    headerView.backgroundColor = UIColor.lightGray

    let label = UILabel()
    label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)
    label.text = "Articles"
    label.font = UIFont.boldSystemFont(ofSize: 16.0)
    label.textAlignment = .center;

    headerView.addSubview(label)

    return headerView
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1;
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArticleTableViewCell
    
    return cell
}
    
}

