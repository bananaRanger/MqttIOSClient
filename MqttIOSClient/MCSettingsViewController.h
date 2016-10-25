//
//  MCSettingsViewController.h
//  MqttIOSClient
//
//  Created by Anthony on 21.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSettings.h"

@interface MCSettingsViewController : UIViewController
{
    MCSettings *_settings;
}

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *portTextField;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

- (IBAction) okButtonClick : (id) sender;

@end
