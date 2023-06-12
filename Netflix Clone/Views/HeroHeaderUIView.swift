//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by BS1096 on 7/6/23.
//

import UIKit

class HeroHeaderUIView: UIView {

    
    private let removeButton: UIButton = {
       
        let button = UIButton()
        
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium);
            let removeIcon = UIImage(systemName: "xmark.circle.fill", withConfiguration: configuration);
        
            button.setImage(removeIcon, for: .normal)
            button.tintColor = .white
            button.backgroundColor = .clear
            button.layer.cornerRadius = button.bounds.width / 2
            button.layer.masksToBounds = true
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 0
            button.translatesAutoresizingMaskIntoConstraints = false

            return button
    }()
    
    private let downloadButton: UIButton = {
       
        let button = UIButton();
        button.setTitle("Download", for: .normal);
        button.layer.borderColor = UIColor.white.cgColor;
        button.layer.borderWidth = 1;
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.layer.cornerRadius = 5;
        
        return button;
    }()
    
    private let playButton: UIButton = {
       
        let button = UIButton();
        button.setTitle("Play", for: .normal);
        button.layer.borderColor = UIColor.white.cgColor;
        button.layer.borderWidth = 1;
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.layer.cornerRadius = 5;
        
        return button;
        
    }()
    
    private let heroImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds  = true
        imageView.image = UIImage(named: "splash")
        
        return imageView
    }()
    
    private func addGradient() {
        
        let gradientLayer = CAGradientLayer();
        
        gradientLayer.colors = [
        
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        addSubview(removeButton)
        
        applyConstraints()
    }
    
    
    private func applyConstraints() {
        
        
        let removeButtonConstraints = [
        
            removeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            removeButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            removeButton.widthAnchor.constraint(equalToConstant: 30)
        ]
        
        let playButtonConstraints = [
        
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let DownloadButtonConstraints = [
        
        
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
            
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(DownloadButtonConstraints)
        
        NSLayoutConstraint.activate(removeButtonConstraints)
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews();
        
        heroImageView.frame = bounds;
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
