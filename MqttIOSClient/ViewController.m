//
//  ViewController.m
//  MqttIOSClient
//
//  Created by Anthony on 18.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[MCSettings sharedInstance] load];
    
    self->_client = [[MQTT alloc] init];
}

- (IBAction) changeClientStateButton : (id) sender {

    if ([sender isKindOfClass:[UIButton class]]) {
    
        if ([sender isEqual:self.connectButton]) {
            [self->_client connect];
        } else if ([sender isEqual:self.disconnectButton]) {
            [self->_client disconnect];
        }
    }
}


@end
