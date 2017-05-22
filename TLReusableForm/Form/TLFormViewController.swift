//
//  TLSimpleFormViewController.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/17/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import UIKit

public class TLFormViewController: UIViewController {

    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        return collectionView
    }()
    
    private var collectionLayout: TLFormCollectionViewLayout
    private var dataSource: TLFormDataSource
    
    private var formBuilder: TLFormBuilder
    private var reusableItems: [[TLFormReusableItem]]
    private var items: [[TLFormItem]]
    
    public init(formBuilder: TLFormBuilder) {
        
        self.formBuilder = formBuilder
        self.items = formBuilder.itemList
        
        self.reusableItems = [[TLFormReusableItem]]()
        
        for item in items {
            let reusableList = item.map { item -> TLFormReusableItem in
                return item.item
            }
            reusableItems.append(reusableList)
        }
        
        if let setup = formBuilder.formSetup {
            collectionLayout = TLFormCollectionViewLayout(itemList: reusableItems, sectionConfiguration: setup)
        } else {
            collectionLayout = TLFormCollectionViewLayout(itemList: reusableItems, sectionConfiguration: TLSectionSetup())
        }
        
        dataSource = TLFormDataSource(itemList: reusableItems)
        
        super.init(nibName: nil, bundle: nil)
    
        setupDefaultItems()
        registerCustomItems(itemList: reusableItems)
        collectionView.collectionViewLayout = collectionLayout
        collectionView.dataSource = dataSource
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    public weak var collectionViewDelegate: UICollectionViewDelegate? {
        didSet {
            collectionView.delegate = collectionViewDelegate
        }
    }
    
    public weak var customItemDataSource: TLFormCustomItemDataSource? {
        didSet {
            dataSource.customItemDataSource = customItemDataSource
        }
    }
    
    private func getReusableItems(items: [[TLFormItem]]) -> [[TLFormReusableItem]] {
        
        var reusableItems = [[TLFormReusableItem]]()
        
        for item in items {
            
            let reusableList = item.map({ item -> TLFormReusableItem in
                return item.item
            })
            
            reusableItems.append(reusableList)
        }
        return reusableItems
    }
    
    private func setupDefaultItems() {
        
        let testingItemBuilder = TLTestingItemBuilder()
        let textfieldItemBuilder = TLTextFieldItemBuilder()
        
        collectionView.register(testingItemBuilder.cellClass, forCellWithReuseIdentifier: testingItemBuilder.itemIdentifier)
        collectionView.register(textfieldItemBuilder.cellClass, forCellWithReuseIdentifier: textfieldItemBuilder.itemIdentifier)
    }
    
    private func setupCollectionView() {
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
    }

    private func registerCustomItems(itemList: [[TLFormReusableItem]]) {
        
        var registeredIdentifiers = [String]()
        
        for sectionItem in itemList{
            
            for item in sectionItem {
                
                switch item {
                case .custom(let builder):
                    
                    if !registeredIdentifiers.contains(builder.itemIdentifier) {
                        
                        if let cellClass = builder.cellClass {
                            collectionView.register(cellClass, forCellWithReuseIdentifier: builder.itemIdentifier)
                            registeredIdentifiers.append(builder.itemIdentifier)
                        } else if let nib = builder.nib {
                            collectionView.register(nib, forCellWithReuseIdentifier: builder.itemIdentifier)
                            registeredIdentifiers.append(builder.itemIdentifier)
                        }
                    }
                    
                default: break
                }
                
            }
        }
        
    }

}



