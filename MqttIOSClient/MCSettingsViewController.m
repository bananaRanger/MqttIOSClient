//
//  MCSettingsViewController.m
//  MqttIOSClient
//
//  Created by Anthony on 21.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCSettingsViewController.h"

static NSString *MCREPattern = @"^(([0-9]{1}|[0-9]{2}|1[0-9][0-9]|2[0-5][0-5])\\.){3}([0-9]{1}|[0-9]{2}|1[0-9][0-9]|2[0-5][0-5])$";

@interface MCSettingsViewController ()

@end

@implementation MCSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self->_settings = [MCSettings sharedInstance];
    [self->_settings load];
    
    self.addressTextField.text = self->_settings.address;
    self.portTextField.text = [NSString stringWithFormat:@"%li", self->_settings.port];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) okButtonClick : (id) sender {

    if ([sender isKindOfClass:[UIButton class]]) {
        
        NSString *string = self.addressTextField.text;
        NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:MCREPattern options:NSRegularExpressionCaseInsensitive error:nil];
        NSInteger count = [regexp numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
        
        if (count == 1) {
            self->_settings.address = self.addressTextField.text;
            self->_settings.port    = self.portTextField.text.integerValue;
            [self->_settings save];
            
            [self.navigationController popViewControllerAnimated:true];
        } else {
            NSLog(@"ERROR");
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
