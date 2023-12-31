//
//  SampleController.swift
//  Sample2
//
//  Created by Ajay Sarkate on 25/07/23.
//

import UIKit

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var fullViewLeadingConstraint: NSLayoutConstraint!
    var fullViewTrailingConstraint: NSLayoutConstraint!
    var bottomConstraint: NSLayoutConstraint!
    
    var tags = [Tag]() {
        didSet {
            if tags.count != 0 {
                DispatchQueue.main.async {
                    if self.aiv.isAnimating {
                        self.aiv.stopAnimating()
                    }
                }
            }
        }
    }
    
    let id = "CollectionViewCell"
    let viewModel = ViewModel()
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Tag>
    lazy var dataSource = configureDataSource()
    
    let aiv =  UIActivityIndicatorView(style: .large)
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        
        collectionView.addSubview(aiv)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        aiv.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(TempCell.self, forCellWithReuseIdentifier: id)
        viewModel.loadData { tags in
            self.tags = tags.filter { tag in
                tag.source != nil
            }
            
            DispatchQueue.main.async {
                self.updateSnapshot()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let tag = tags[indexPath.item]
        
        guard let source = tag.source else {
            return .zero
        }
        
        
        let width = view.frame.width - 48
        let height = (source.cover_photo.height * width) / source.cover_photo.width
        
        return .init(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addFullScreenView(index: indexPath.item)
    }
    
    func addFullScreenView(index: Int) {
        let tag = tags[index]
        guard let source = tag.source else { return }
        
        guard let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? TempCell else {
            return
        }
        
        let taskView = TaskView()
        let height = (source.cover_photo.height * (view.frame.width - 48)) / source.cover_photo.width
        taskView.heightConstraint.constant = height

        taskView.title.text = tag.title.capitalized
        taskView.title.alpha = 0
        taskView.button.alpha = 0
        taskView.imageView.image = cell.imageView.image
        taskView.layer.cornerRadius = 16
        taskView.text.text = source.description
        
        view.addSubview(taskView)

        
        taskView.translatesAutoresizingMaskIntoConstraints = false
        taskView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fullViewLeadingConstraint = taskView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        fullViewLeadingConstraint.isActive = true
        fullViewTrailingConstraint = taskView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        fullViewTrailingConstraint.isActive = true
        bottomConstraint = taskView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomConstraint.isActive = true
        
        let transform = CGAffineTransform(translationX: 0, y: cell.frame.minY - collectionView.contentOffset.y)
        taskView.transform = transform
        let temp = view.frame.height - height
        bottomConstraint.constant = -temp
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.36, delay: 0.2) {
            taskView.title.alpha = 1
            taskView.button.alpha = 1
        }
        
        UIView.animate(withDuration: 0.36) {
            taskView.layer.cornerRadius = 0
            self.bottomConstraint.constant = 0
            self.fullViewLeadingConstraint.constant = 0
            self.fullViewTrailingConstraint.constant = 0
            let height = (source.cover_photo.height * self.view.frame.width) / source.cover_photo.width
            taskView.heightConstraint.constant = height
            taskView.transform = .identity

            self.view.layoutIfNeeded()
        }
        
        taskView.closeHandler = {
            
            taskView.button.alpha = 0
            taskView.title.alpha = 0
            taskView.desc.alpha = 0
            taskView.text.alpha = 0
            
            UIView.animate(withDuration: 0.36, animations: {
                taskView.layer.cornerRadius = 16
                self.bottomConstraint.constant = -temp
                self.fullViewLeadingConstraint.constant = 24
                self.fullViewTrailingConstraint.constant = -24
                let height = (source.cover_photo.height * self.view.frame.width - 48) / source.cover_photo.width
                taskView.heightConstraint.constant = height
                let transform = CGAffineTransform(translationX: 0, y: cell.frame.minY - self.collectionView.contentOffset.y)
                taskView.transform = transform

                self.view.layoutIfNeeded()
            }, completion: {_ in
                taskView.removeFromSuperview()
            })
        }
    }
}
