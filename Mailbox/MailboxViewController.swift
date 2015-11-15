//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Dadhaniya, Janak on 11/9/15.
//  Copyright © 2015 Dadhaniya, Janak. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var messageView: UIImageView!
    
    var initialCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: 320, height: 1202)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    
    }
 
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            self.initialCenter = messageView.center
            archiveIcon.alpha = 0
            laterIcon.alpha = 0
            deleteIcon.alpha = 0
            listIcon.alpha = 0
           
            
        }
        
        else if sender.state == UIGestureRecognizerState.Changed {
            
            messageView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
            
            
            //GO RIGHT
            
            if velocity.x >= 0 {
                
                //Animate
                
                archiveIcon.alpha = 1
            }
            
            //GO LEFT
                
            else if velocity.x < 0 {
                
                //Animate
                
                laterIcon.alpha = 1
            }
            
            
            
                //MAKE GREY AND SET ICONS TO TRANSPARENT
                
                if translation.x > -60 && translation.x < 60 {
                    self.backgroundView.backgroundColor = UIColor.grayColor()
                   
                    
                }
                
                //MAKE GREEN ARCHIVE ICON TRANSLATE
                
                else if translation.x >= 60 {
                    backgroundView.backgroundColor = UIColor.greenColor()
                    
                }
            
                //MAKE RED + DELETE ICON TRANSLATE
            
                else if translation.x >= 260 {
                    backgroundView.backgroundColor = UIColor.redColor()
            }
                
                
            
            
            
                
            
                
                //MAKE YELLOW + LATER ICON TRANSLATE
                
                 else if translation.x <= -60 {
                    backgroundView.backgroundColor = UIColor.yellowColor()
                }
                
                //MAKE BROWN + LIST ICON TRANSLATE
                else if translation.x <= -260 {
                    backgroundView.backgroundColor = UIColor.brownColor()
            }
                
            
            
            
        }
            
        else if sender.state == UIGestureRecognizerState.Ended {
            
            messageView.center = initialCenter
            
        }
        
        
    }
    

    
    }



    



