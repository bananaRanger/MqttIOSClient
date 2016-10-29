//
//  ViewController.h
//  MqttIOSClient
//
//  Created by Anthony on 18.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCDashboardViewController.h"
#import "MQTT.h"

typedef enum {

    MCNilLoginError     = 1,
    MCNilPasswordError  = 2,
    MCDifferentPassword = 3,
    MCShortPassword     = 4,
    MCWithoutError      = 5
} MCInputError;

@interface ViewController : UIViewController
{
    MQTT *_client;
}

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorMessageLabel;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;

- (IBAction) connectButton : (id) sender;
- (IBAction) disconnectTCPButton : (id) sender;

@end

