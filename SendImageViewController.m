//
//  SendImageViewController.m
//  AttendanceManagement
//
//  Created by Welltime on 21/01/2015.
//  Copyright (c) 2015 Welltime. All rights reserved.
//

#import "SendImageViewController.h"

@interface SendImageViewController ()

@end

@implementation SendImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myImageView.image=self.data;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)segmentSwitch:(id)sender {
}


@end
