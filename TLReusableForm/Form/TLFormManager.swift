//
//  TLFormManager.swift
//  TLReusableForm
//
//  Created by Diego Espinoza on 5/23/17.
//  Copyright © 2017 TektonLabs. All rights reserved.
//

import Foundation

public class TLFormManager {
    
    internal var dataSource: TLFormDataSource
    internal var viewController: TLFormViewController
    
    internal var formBuilder: TLFormBuilder
    internal var items: [[TLFormItem]]
    
    public weak var collectionViewDelegate: UICollectionViewDelegate? {
        didSet {
            viewController.collectionViewDelegate = collectionViewDelegate
        }
    }
    
    public weak var customItemDataSource: TLFormCustomItemDataSource? {
        didSet {
            dataSource.customItemDataSource = customItemDataSource
        }
    }
    
    public init(builder: TLFormBuilder) {
        
        formBuilder = builder
        items = formBuilder.itemList
        
        let reusableItems = items.map { sectionItems -> [TLFormReusableItem] in
            return sectionItems.map({ item -> TLFormReusableItem in
                return item.item
            })
        }
        
        dataSource = TLFormDataSource(items: reusableItems)
        viewController = TLFormViewController(dataSource: dataSource, reusableItems: reusableItems, sectionSetup: formBuilder.formSetup)
    }
    
    public func addForm(to parentViewController: UIViewController, inside containerView: UIView) {
        
        parentViewController.addChildViewController(viewController)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(viewController.view)
        
        NSLayoutConstraint(item: viewController.view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: viewController.view, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: viewController.view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: viewController.view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        
        viewController.didMove(toParentViewController: parentViewController)
    }
    
    public func update<Model>(cellModel: Model, at indexPath: IndexPath) -> Bool {
        
        let item = dataSource.getItem(at: indexPath)
        guard let newItem = TLTextFieldItemCellModel.createNew(item: item, model: cellModel) else { return false }

        dataSource.update(item: newItem, at: indexPath)
        reloadItems(at: [indexPath])
        return true
    }
    
    public func getAllItems() -> [[TLFormReusableItem]] {
        return dataSource.getAllItems()
    }
    
    public func reloadItems(at indexPaths: [IndexPath]) {
        viewController.reloadItems(at: indexPaths)
    }
    
    public func reloadData() {
        viewController.reloadData()
    }

}
