//
//  TitleTableViewCell.swift
//  NetflixClone
//
//  Created by Akın Aksoy on 21.04.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    static let identefier = "TitleTableViewCell"
    // Celldeki itemler olusturuluyor.
    private let playTitleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle",withConfiguration:  UIImage.SymbolConfiguration(pointSize: 30))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titlesPosterUIImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let releaseDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemIndigo
        return label
    }()
    
    private func applyContraints() {
        // Celldeki itemlerin konumları belirleniyor.
        let titlesPosterUIImageViewContraints = [
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let titleLabelContraints = [
            titleLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let playTitleButtonContraints = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        let releaseDateLabelContraints = [
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 20),
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor,constant: 30)
        ]
        // olusturulan itemler ve konumlar layoutta active ediliyor.
        NSLayoutConstraint.activate(titlesPosterUIImageViewContraints)
        NSLayoutConstraint.activate(titleLabelContraints)
        NSLayoutConstraint.activate(playTitleButtonContraints)
        NSLayoutConstraint.activate(releaseDateLabelContraints)
    }
    
    override init(style : UITableViewCell.CellStyle,reuseIdentifier : String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //olusturulmus itemler celle ekleniyor.
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        contentView.addSubview(releaseDateLabel)
        applyContraints()
    }
    required init(coder : NSCoder) {
        fatalError()
    }
    
    // celldeki veriler dolduruluyor.
    public func configure(with model : UpcomingTitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else {return}
        titlesPosterUIImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        releaseDateLabel.text = "Release Date : \(model.releaseDate)"
    }
    
    
}
