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
    @IBOutlet weak var rightIconView: UIView!
    @IBOutlet weak var leftIconsView: UIView!
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    @IBOutlet weak var rescheduleView: UIImageView!
    
    @IBOutlet weak var masterView: UIView!
    
    @IBOutlet var edgePan: UIScreenEdgePanGestureRecognizer!
    
    var initialCenter: CGPoint!
    var initialCenterRightIcons: CGPoint!
    var initialCenterLeftIcons: CGPoint!
    var endState = 0
    
    var masterViewOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.contentSize = CGSize(width: 320, height: 1202)
        listView.alpha = 0
        rescheduleView.alpha = 0
        
        masterViewOriginalCenter = masterView.center
        
        edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgePan.edges = UIRectEdge.Left
        view.addGestureRecognizer(edgePan)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    
    }
 
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        let location = sender.locationInView(view)
        let translation = sender.translationInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            self.initialCenter = messageView.center
            self.initialCenterLeftIcons = leftIconsView.center
            self.initialCenterRightIcons = rightIconView.center
            
            resetAll()
           
            
        }
        
        else if sender.state == UIGestureRecognizerState.Changed {
            
            messageView.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y)
        
            
                //GREY RIGHT
            
            if translation.x > -60 && translation.x < 0 {
                
                backgroundView.backgroundColor = UIColor.grayColor()
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.laterIcon.alpha = 1
                })
                endState = 0

                }
            
                //GREY LEFT
                
            if  translation.x > 0 &&  translation.x < 60 {
                
                backgroundView.backgroundColor = UIColor.grayColor()
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.archiveIcon.alpha = 1
                })
                endState = 0

                }
            
                //GREEN ARCHIVE ICON TRANSLATE
                
            else if translation.x >= 60 && translation.x < 260 {
                backgroundView.backgroundColor = UIColor.greenColor()
                resetAll()
                archiveIcon.alpha = 1
                leftIconsView.center = CGPoint(x: initialCenterLeftIcons.x + translation.x - 60, y: initialCenterLeftIcons.y)
                endState = 0
                
            }
            
                //RED + DELETE ICON TRANSLATE
            
            else if translation.x >= 260 {
                backgroundView.backgroundColor = UIColor.redColor()
                resetAll()
                
                deleteIcon.alpha = 1
                
                
                leftIconsView.center = CGPoint(x: initialCenterLeftIcons.x + translation.x - 60, y: initialCenterLeftIcons.y)
                endState = 0
            }
                
                //YELLOW + LATER ICON TRANSLATE
                
            else if translation.x <= -60 && translation.x > -260 {
                backgroundView.backgroundColor = UIColor.yellowColor()
                resetAll()
                laterIcon.alpha = 1
                rightIconView.center = CGPoint(x: initialCenterRightIcons.x + translation.x + 60, y: initialCenterRightIcons.y)
                endState = 1

                
                }
                
                //BROWN + LIST ICON TRANSLATE
                
            else if translation.x <= -260 {
                backgroundView.backgroundColor = UIColor.brownColor()
                resetAll()
                listIcon.alpha = 1

                rightIconView.center = CGPoint(x: initialCenterRightIcons.x + translation.x + 60, y: initialCenterRightIcons.y)
                endState = 2
            }

            
        }
            
        else if sender.state == UIGestureRecognizerState.Ended {
            leftIconsView.center = initialCenterLeftIcons
            rightIconView.center = initialCenterRightIcons
            messageView.center = initialCenter
            
            if endState == 0 {
                self.messageView.alpha = 0
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    
                    self.feedImageView.center.y = self.feedImageView.center.y + 86.0
                })
                
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                   self.messageView.alpha = 1
                   self.feedImageView.center.y = self.feedImageView.center.y - 86.0

                })
            }
            
            
            if endState == 1 {
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.rescheduleView.alpha = 1
                })
                
                
                
            }
            if endState == 2 {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.listView.alpha = 1
                })
                
                
            }
        }
        
        
    }
    
    func resetAll () {
        archiveIcon.alpha = 0
        laterIcon.alpha = 0
        deleteIcon.alpha = 0
        listIcon.alpha = 0
    }
    
    @IBAction func didTapReschedule(sender: UITapGestureRecognizer) {
        rescheduleView.alpha = 0
        self.messageView.alpha = 0

        UIView.animateWithDuration(0.8) { () -> Void in
            self.feedImageView.center.y  = self.feedImageView.center.y  + 86
        }
        UIView.animateWithDuration(0.1) { () -> Void in
            self.feedImageView.center.y = self.feedImageView.center.y - 86
            self.messageView.alpha = 1
        }
    }

    @IBAction func didTapList(sender: UITapGestureRecognizer) {
        listView.alpha = 0
        self.messageView.alpha = 0

        UIView.animateWithDuration(0.5) { () -> Void in
            self.feedImageView.center.y  = self.feedImageView.center.y  + 86
        }
        UIView.animateWithDuration(0.1) { () -> Void in
            self.feedImageView.center.y = self.feedImageView.center.y - 86
            self.messageView.alpha = 1
        }
    }
    
    func onEdgePan(edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer){
        
        let translation = edgePanGestureRecognizer.translationInView(view)
        
        if edgePanGestureRecognizer.state == UIGestureRecognizerState.Began {
            
        }
        else if edgePanGestureRecognizer.state == UIGestureRecognizerState.Changed {
            
            masterView.center.x = masterViewOriginalCenter.x + translation.x
            
        }
        else if edgePanGestureRecognizer.state == UIGestureRecognizerState.Ended {
            let width = UIScreen.mainScreen().bounds.width
            
            if (masterView.center.x - masterViewOriginalCenter.x < width/2.0) {
                masterView.center.x = masterViewOriginalCenter.x
            }
            
            else {
                masterView.center.x = masterViewOriginalCenter.x + width
            }
            
        }
    }
    
    
    
    
    }



    



