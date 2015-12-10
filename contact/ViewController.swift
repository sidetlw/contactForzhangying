//
//  ViewController.swift
//  contact
//
//  Created by test on 11/24/15.
//  Copyright © 2015 Mrtang. All rights reserved.
//

import UIKit
var todoArrays:[TodoModel] = []


class ViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todoArrays = [ TodoModel(imageUrl: "http://www.easyicon.cn/download/png/579335/256/", name: "张三", gender: "男",phoneNumber:"1698658976"),
                    TodoModel(imageUrl: "http://www.easyicon.cn/download/png/579300/256/", name: "李四", gender:  "男",phoneNumber:"16956464564"),
                    TodoModel(imageUrl: "http://www.easyicon.cn/download/png/579320/256/", name: "王二", gender: "男",phoneNumber:"13678787878"),
                    TodoModel(imageUrl: "http://www.easyicon.cn/download/png/579305/256/", name: "刘七",gender: "男",phoneNumber:"13865895656"),
        ]
        
        tableview.dataSource = self
        tableview.delegate = self

        tableview.reloadData()

    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mycell", forIndexPath: indexPath)
        var model:TodoModel
        model = todoArrays[indexPath.row] as TodoModel
        
        var avatarimage = cell.viewWithTag(201) as! UIImageView
        var nameLabel = cell.viewWithTag(202) as! UILabel
        var gendrLabel = cell.viewWithTag(203) as! UILabel
        var phoneLabel = cell.viewWithTag(204) as! UILabel
        
        nameLabel.text = model.name
        gendrLabel.text = model.gender
        phoneLabel.text = model.phoneNumber
        
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfig)
        
        let myurl = model.imageUrl
        let url:NSURL = NSURL(string:myurl)!
        
        print(url)
        //================
        var cacheFilename = url.pathComponents![(url.pathComponents?.count)! - 2]
        var cachePath = FileUtility.cachePath(cacheFilename)
        var image : AnyObject = FileUtility.imageDataFromPath(cachePath)
        //  println(cachePath)
        if image as! NSObject != NSNull()
        {
            avatarimage.image = image as? UIImage
        }
        else {
            let requst = NSURLRequest(URL: url)
            let task = session.dataTaskWithRequest(requst) { (data, response, error) -> Void in
                if error != nil {
                    return
                }
                
                guard let wappeddata = data else {
                    
                    return
                }
                
                if let image = UIImage(data: wappeddata) {
                    avatarimage.image = image
                    FileUtility.imageCacheToPath(cachePath,image: wappeddata)
                }
                
            }
            task.resume()

        }

        //================
        return cell

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArrays.count
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }


}

