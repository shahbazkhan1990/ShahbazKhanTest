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
    var activityView:UIActivityIndicatorView?;
    
    var isDataLoading:Bool=false
    var pageNo:Int=1
    var limit:Int=10
    var offset:Int=0 //pageNo*limit
    var didEndReached:Bool=false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.estimatedRowHeight = 500.0
        self.tblView.rowHeight = UITableView.automaticDimension
        getData()
    }
    
    func getData()
    {
        showActivityIndicator()
        if Reachability.isConnectedToNetwork(){
        viewModel.getDataFromAPIHandlerClass(pagenumber: String(pageNo)){[weak self] (arrUser) in
            
            if(arrUser.count > 0){
                DispatchQueue.main.async { [weak self] in
                    self?.hideActivityIndicator()
                    self?.tblView.reloadData()
                    self?.isDataLoading = false;
                }
            }else{
                DispatchQueue.main.async {
                    self?.hideActivityIndicator()
                    self?.isDataLoading = true;
                    var alertStyle = UIAlertController.Style.actionSheet
                    if (UIDevice.current.userInterfaceIdiom == .pad) {
                      alertStyle = UIAlertController.Style.alert
                    }

                    let alertController = UIAlertController(title: "No More Data", message: nil, preferredStyle: alertStyle)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self?.present(alertController, animated: true)
                }
            }
        }
        }else{
            self.hideActivityIndicator()
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !Reachability.isConnectedToNetwork(){
            var alertStyle = UIAlertController.Style.actionSheet
            if (UIDevice.current.userInterfaceIdiom == .pad) {
              alertStyle = UIAlertController.Style.alert
            }

            let alertController = UIAlertController(title: "No Internet Connection!", message: nil, preferredStyle: alertStyle)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large);
        activityView?.center = self.view.center
        self.view.addSubview((activityView ?? nil)!)
        activityView?.startAnimating()
    }

    func hideActivityIndicator()
    {
        activityView!.stopAnimating()
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
    return  viewModel.getNumberOfRowsInSection();
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArticleTableViewCell
        cell.userName.text = viewModel.getUserName(index: indexPath.row)
         let userImgUrl = viewModel.getUserAvatar(index: indexPath.row)
        if(userImgUrl != ""){
            cell.userImgView.loadImageUsingCache(withUrl: userImgUrl, from: "1")
        }
        cell.userDesg.text = viewModel.getUserDesig(index: indexPath.row)
        
        let ArticleImgUrl = viewModel.getMediaImage(index: indexPath.row)
        if(ArticleImgUrl != ""){
            cell.ArticleImageViewHeight.constant = 150;
            cell.articleImgView.loadImageUsingCache(withUrl: ArticleImgUrl, from: "2")
        }else{
            cell.ArticleImageViewHeight.constant = 0;
        }
        cell.articleTitle.text = viewModel.getMediaTitle(index: indexPath.row)
        cell.articleUrl.text = viewModel.getMediaUrl(index: indexPath.row)
        
        cell.articleDate.text = viewModel.getCreatedDate(index: indexPath.row)
        cell.articleContent.text = viewModel.getContent(index: indexPath.row)
        cell.comments.text = viewModel.getComments(index: indexPath.row)
        cell.likes.text = viewModel.getLikes(index: indexPath.row)
        
    let check = viewModel.checkEveryTenthRow(index: indexPath.row + 1)
        if(check){
            if(indexPath.row != 0){
            self.showToast(message: "Page No : \(String((indexPath.row / 10)+1))", font: UIFont.systemFont(ofSize: 12))
            }
        }
        return cell
    }
    
    
    
    // For Pagination
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

            print("scrollViewDidEndDragging")
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height){
                
               
                if !isDataLoading{
                        isDataLoading = true
                        self.pageNo=self.pageNo+1
                        self.limit=self.limit+10
                        self.offset=self.limit * self.pageNo
                        getData()
                }
            }


    }
    
}


let imageCacheArtical = NSCache<NSString, UIImage>()
let imageCacheUser = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String, from:String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if(from == "1"){
            if let cachedImage = imageCacheUser.object(forKey: urlString as NSString)  {
                self.image = cachedImage
                return
            }
        }else{
            if let cachedImage = imageCacheArtical.object(forKey: urlString as NSString)  {
                self.image = cachedImage
                return
            }
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.center = .init(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    if(from == "1"){
                        imageCacheUser.setObject(image, forKey: urlString as NSString)
                    }else{
                        imageCacheArtical.setObject(image, forKey: urlString as NSString)
                    }
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}

extension UIViewController {

func showToast(message : String, font: UIFont) {
    
    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
    
}
    
}
