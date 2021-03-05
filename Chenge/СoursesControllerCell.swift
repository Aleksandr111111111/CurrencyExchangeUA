//
//  СoursesControllerCell.swift
//  Chenge
//
//  Created by Aleksander Kulikov on 21.01.2021.
//

import UIKit

class CoursesControllerCell: UITableViewCell {
    
    
    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelCurrencyName: UILabel!
    
    func initCelll(currency: Currency) {
        imageFlag.image = currency.imageFlag
        labelCurrencyName.text = currency.Name
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
