//
//  UpComingViewController.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 19.04.2022.
//

import UIKit

class UpComingViewController: UIViewController {
    private var titles: [Title] = [Title]()
    
    //upComing table i olusturuldu
    private let upComingTable : UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identefier)
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
        
        fetchUpcoming()
    }
    override func viewDidLayoutSubviews() {
        // Table'in screende gözükmesi için
        super.viewDidLayoutSubviews()
        upComingTable.frame = view.bounds
    }
    // titlelar(movies) dizisi olusturuluyor
    private func fetchUpcoming(){
        APICaller.shared.getUpcomingMovie { result in
            switch result {
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async{
                    self.upComingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


extension UpComingViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identefier,for : indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        // doldurulan title dizisinde gerekli olan datalar view modele aktarılıyor.
        cell.configure(with: UpcomingTitleViewModel(titleName: title.original_title ?? title.original_name ?? "unknown" , posterURL: title.poster_path ?? "unknown" ,releaseDate: title.release_date ?? "Coming soon"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else {
            return
        }
        
        APICaller.shared.getYoutubeVideo(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            case .failure(let error) :
                print(error.localizedDescription)
            }
        }
    }
    
}
