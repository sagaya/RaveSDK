//
//  SaveCardViewController.swift
//  GetBarter
//
//  Created by Olusegun Solaja on 10/10/2018.
//  Copyright © 2018 Olusegun Solaja. All rights reserved.
//

import UIKit
protocol CardSelect:class {
    func cardSelected(card:SavedCard?)
}

class SaveCardViewController: UIViewController {
    var savedCards:[SavedCard]?
    @IBOutlet weak var saveCardTable: UITableView!
    weak var delegate:CardSelect?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView(){
        saveCardTable.delegate = self
        saveCardTable.dataSource = self
        saveCardTable.tableFooterView = UIView(frame: .zero)
        saveCardTable.rowHeight = 74
    }
    


}

extension SaveCardViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCards?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "saveCard") as! SaveCardCell
        let card =  self.savedCards?[indexPath.row]
        cell.maskCardLabel.text = card?.card?.maskedPan
        cell.brandImage.image = card?.card?.cardBrand?.lowercased() == .some("visa") ? UIImage(named: "rave_visa") : UIImage(named: "rave_mastercard")
        cell.contentContainer.layer.cornerRadius = 8
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let card =  self.savedCards?[indexPath.row]
      delegate?.cardSelected(card: card)
    }
    
    
}
