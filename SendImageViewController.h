//
//  SendImageViewController.h
//  AttendanceManagement
//
//  Created by Welltime on 21/01/2015.
//  Copyright (c) 2015 Welltime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendImageViewController : UIViewController

- (IBAction)segmentSwitch:(id)sender;

@property (nonatomic, retain) UIImage *data;

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end
