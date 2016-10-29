//
//  MCDashboardViewController.m
//  MqttIOSClient
//
//  Created by Anthony on 28.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCDashboardViewController.h"

@interface MCDashboardViewController ()

@end

@implementation MCDashboardViewController

@synthesize client = _client;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.helloLabel.text = self.helloString;
    
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = true;
}

- (IBAction) disconnectButton : (id) sender {

    if ([sender isKindOfClass:[UIButton class]]) {
        
        if ([sender isEqual:self.disconnectButton]) {
            [self->_client disconnect];
            
            [self.navigationController popViewControllerAnimated:true];
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
