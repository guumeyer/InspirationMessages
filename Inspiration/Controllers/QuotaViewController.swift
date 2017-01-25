//
//  QuotaViewController.swift
//  Inspiration
//
//  Created by gustavo r meyer on 1/21/17.
//  Copyright © 2017 gustavo r meyer. All rights reserved.
//

import UIKit

class QuotaViewController: UIViewController {

    // MARK: - Variable
    
    
    // MARK: - Outlets
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var randomQuotaButton: UIButton!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteLabel.alpha = 0
        authorLabel.alpha = 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Actions
    @IBAction func randomQuoteButtonDidTouch(sender: UIButton){
        setQuote()
    }
    // MARK: - Functions
    func setQuote(){
        //fadeOut
        fadeOut()
        
        //getting data from  API
        let dataService = DataService()
        dataService.getQuoteData (completion:
            { (aQuote, aAuthor) in
                
                //quote
                self.quoteLabel.text = "”\(aQuote)”"
                self.quoteLabel.sizeToFit()
                
                //author
                self.authorLabel.text = "- \(aAuthor)"
                if aAuthor.isEmpty{
                    self.authorLabel.text = "- unknown"
                }
                self.quoteLabel.sizeToFit()
                self.quoteLabel.center.y += 30
                self.authorLabel.center.y += 30
                
                UIView.animateKeyframes(withDuration: 10.0, delay: 0.0, options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: {
                    
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.10, animations: {
                        self.fadeIn()
                        self.view.backgroundColor = self.getRandomColor()
                    })
                    UIView.addKeyframe(withRelativeStartTime: 0.10, relativeDuration: 0.5, animations: {
                        self.keyFrameAnimation()
                    })
                    
                    UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 0.10, animations: {
                        self.fadeOut()
                    })
                    
                }, completion: { (finished) in
                    self.setQuote()
                })
        }) {
            self.setQuote()
        }
    }
    func fadeIn(){
        self.quoteLabel.alpha = 1.0
        self.authorLabel.alpha = 1.0
    }
    
    func fadeOut(){
        self.quoteLabel.alpha = 0.0
        self.authorLabel.alpha = 0.0
    }
    
    func getRandomColor() -> UIColor {
        let randomRed:CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))
        let randomGreen:CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))
        let randomBlue:CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))
        
        return UIColor(red:randomRed/255, green:randomGreen/255, blue:randomBlue/255, alpha:0.8)
    }
    
    func keyFrameAnimation(){
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { 
            self.quoteLabel.center.y -= 30
            self.authorLabel.center.y -= 30
        }) { (finished) in
            
        }
    
    }
    
    // MARK: - Navigation

}
