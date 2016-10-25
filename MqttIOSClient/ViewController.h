//
//  ViewController.h
//  MqttIOSClient
//
//  Created by Anthony on 18.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MQTT.h"

@interface ViewController : UIViewController
{
    MQTT *_client;
}

@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;

- (IBAction) changeClientStateButton : (id) sender;

@end

