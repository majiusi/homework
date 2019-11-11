//
//  TableViewCell.swift
//  Homework3
//
//  Created by Margis on 2019/11/11.
//  Copyright © 2019 Margis. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var switchButton: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func switchChanged(_ sender: Any) {
        if switchButton.isOn{
            label.textColor = UIColor.gray
            label.text! += "(finished)"
        }else{
            label.textColor = UIColor.black
            label.text! = String(label.text!.dropLast(10))
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
