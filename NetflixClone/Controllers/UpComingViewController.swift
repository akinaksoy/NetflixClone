//
//  UpComingViewController.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 19.04.2022.
//

import UIKit

class UpComingViewController: UIViewController {

    //upComing table i olusturuldu
    private let upComingTable : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
     }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        //navigation configure edildi.
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        
        view.addSubview(upComingTable)
        upComingTable.delegate = self
        upComingTable.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        // Table'in screende gözükmesi için
        super.viewDidLayoutSubviews()
        upComingTable.frame = view.bounds
    }
}


extension UpComingViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = "Upcoming"
        return cell
        
    }
    
}
