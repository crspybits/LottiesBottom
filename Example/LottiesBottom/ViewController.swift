//
//  ViewController.swift
//  Example
//
//  Created by Christopher G Prince on 9/22/17.
//  Copyright © 2017 Spastic Muffin, LLC. All rights reserved.
//

import UIKit
import LottiesBottom

class ViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let cellReuseId = "CellReuseId"
    var bottomAnimation:LottiesBottom!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseId)
        
        // The size, and the height in particular is fidly. You may have to tweak it to get it positioned to where you want relative to bottom of the scroll view.
        let size = CGSize(width: 200, height: 300)
        
        // The "N" reference below is for the file "N.json" in the bundle. See https://github.com/airbnb/lottie-ios/tree/master/Example/Tests for other examples
        
        bottomAnimation = LottiesBottom(useLottieJSONFileWithName: "N", withSize: size, scrollView: tableView, scrollViewParent: view) {[unowned self] in
            print("Animation completed")
            self.bottomAnimation.hide()
        }
        bottomAnimation.completionThreshold = 0.8
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}

