//
//  MLDetailsViewController.h
//  HappyWife-HappyLife
//
//  Created by MLinc on 2014-06-30.
//  Copyright (c) 2014 Mobi-Learning Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MLDetailsViewController : UIViewController<MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate>
@property(nonatomic, strong) NSString* compliment;
@property(nonatomic)int complimentId;
@end
