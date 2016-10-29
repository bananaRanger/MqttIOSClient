//
//  MCDashboardViewController.h
//  MqttIOSClient
//
//  Created by Anthony on 28.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQTT.h"

@interface MCDashboardViewController : UIViewController
{
    MQTT *_client;
}

@property (strong, nonatomic) MQTT *client;
@property (strong, nonatomic) NSString *helloString;
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;

- (IBAction) disconnectButton : (id) sender;

@end
