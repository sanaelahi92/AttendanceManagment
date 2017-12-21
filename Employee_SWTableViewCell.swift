//
//  Employee_SWTableViewCell.swift
//  AttendanceManagement
//
//  Created by Welltime on 06/06/2017.
//  Copyright © 2017 Welltime. All rights reserved.
//

import UIKit

class Employee_SWTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var lbl_name: UILabel!
    
    
    @IBOutlet weak var lbl_status: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
