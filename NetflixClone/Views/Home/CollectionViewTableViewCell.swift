//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 19.04.2022.
//

import UIKit

protocol CollectionViewTableViewCellDelegate : AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell : CollectionViewTableViewCell, view:TitlePreviewViewModel)
}


class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    // Title listesi oluşturuldu
    private var titles : [Title] = [Title]()
    weak var delegate : CollectionViewTableViewCellDelegate?
    
    // collection view table tasarımı (horizontal)
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // her image viewin görüntüsü
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        // Collection View görünümü TittleCollectionView den çağrıldı.
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    // Title listesinden gelen titlelar ile senkronize veri çekilecek şekilde configure edildi.
    public func configure(with titles : [Title]) {
        self.titles = titles
        DispatchQueue.main.async {
            [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension CollectionViewTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource {
    // collection view table tasarımı (horizontal)
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Cell yapısı collectionview olarak titlecollectionviewden oluşturuldu
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        // titlesdan gelen verilerin mevcut indexpath üzerinden posteri çekildi
        guard let model = titles[indexPath.row].poster_path else {return UICollectionViewCell()}
        // celle çekilmek istenen photonun url'i gönderildi.
        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //Tıklanan itemin title namei alınarak youtube api üzerinden video idsini alma.
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else {
            return
        }
        
        APICaller.shared.getYoutubeVideo(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                let title = self?.titles[indexPath.row]
                guard let strongSelf = self else {
                    return
                }
                let viewModel = TitlePreviewViewModel(title: title?.original_title ?? title?.original_name ?? "Unknown", youtubeView: videoElement, titleOverview: title?.overview ?? "...")
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, view: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
