//
//  FullScreenView.swift
//  CollectionView Project
//
//  Created by Ajay Sarkate on 08/08/23.
//

import UIKit

class TaskView: UIView {
    let title = UILabel()
    let imageView = UIImageView()
    let desc = UILabel()
    let text = UITextView()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        imageView.backgroundColor = .systemBlue
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        title.text = "Hello"
        title.font = .boldSystemFont(ofSize: 48)
        title.backgroundColor = .white
        
        imageView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.topAnchor.constraint(equalTo: imageView.topAnchor,constant:  20).isActive = true
        title.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20).isActive = true
        
        desc.text = "Hi there, how are you?"
        desc.font = .boldSystemFont(ofSize: 32)
        desc.backgroundColor = .yellow
        
        addSubview(desc)
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        desc.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        desc.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        desc.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        desc.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        text.text = "Announced in 2014, the Swift programming language has quickly become one of the fastest growing languages in history. Swift makes it easy to write software that is incredibly fast and safe by design. Our goals for Swift are ambitious: we want to make programming simple things easy, and difficult things possible."
        text.font = .systemFont(ofSize: 24)
        text.isUserInteractionEnabled = false
        
        addSubview(text)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.topAnchor.constraint(equalTo: desc.bottomAnchor).isActive = true
        text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        text.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        button.tintColor = .red
//        button.layer.cornerRadius = 25
        button.setImage(UIImage(systemName: "x.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40)), for: .normal)
        
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 330).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
    }
    
    @objc func handleButton(button: UIButton) {
        print("button working")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}