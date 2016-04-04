// Copyright (c) 22.01.16. Ramotion Inc. (http://ramotion.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var openButton: UIButton!
    var delegate: RXReorderTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.font = UIFont(name: "Hero", size: 18)
      
      
      let colorRed = CGFloat(240 ) / CGFloat(255.0)
      let colorGreen = CGFloat(170 ) / CGFloat(255.0)
      let colorBlue = CGFloat( 103) / CGFloat(255.0)

      self.titleLabel.textColor =   UIColor(red: colorRed, green: colorGreen, blue: colorBlue, alpha: CGFloat(1.0)
      )

        // Initialization code
    }
  
  
  func setOpenedMode(isOpen:Bool){
    if isOpen{
      openedMode()
    }else{
      closedMode()
    }
  }
  
  
  private func openedMode(){
    let colorRed = CGFloat(240 ) / CGFloat(255.0)
    let colorGreen = CGFloat(170 ) / CGFloat(255.0)
    let colorBlue = CGFloat( 103) / CGFloat(255.0)
    
    self.titleLabel.textColor =   UIColor(red: colorRed, green: colorGreen, blue: colorBlue, alpha: CGFloat(1.0)
    )

  }
  
  private func closedMode(){
    
    let colorRed = CGFloat(158 ) / CGFloat(255.0)
    let colorGreen = CGFloat(139 ) / CGFloat(255.0)
    let colorBlue = CGFloat( 131) / CGFloat(255.0)
    
    self.titleLabel.textColor =   UIColor(red: colorRed, green: colorGreen, blue: colorBlue, alpha: CGFloat(1.0)
    )
    
  }

    @IBAction func openAction(sender: AnyObject) {
       delegate?.changeOpenStateByCell!(self)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
