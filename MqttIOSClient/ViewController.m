//
//  ViewController.m
//  MqttIOSClient
//
//  Created by Anthony on 18.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "ViewController.h"

static NSString *const MCDashboardSegue = @"MCDashboardSegue";
static NSInteger MCMinPasswordLength = 1;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[MCSettings sharedInstance] load];
    
    self->_client = [[MQTT alloc] init];
}

- (IBAction) connectButton : (id) sender {

    if ([sender isKindOfClass:[UIButton class]]) {
    
        if ([sender isEqual:self.connectButton]) {
            
            MCInputError errorType = [self isConnectionDataValid];
            
            if (errorType == MCWithoutError) {
                
                MCConnect *connect = [[MCConnect alloc] init];
                connect.username = self.loginTextField.text;
                connect.password = self.passwordTextField.text;
            
                [self->_client connect:connect];
            
                [self performSegueWithIdentifier:MCDashboardSegue sender:self];
            } else {
            
                switch (errorType) {
                    case MCNilLoginError:       [self setErrorMessage:@"Login field must not be empty"]; break;
                    case MCNilPasswordError:    [self setErrorMessage:@"Password field must not be empty"]; break;
                    case MCDifferentPassword:   [self setErrorMessage:@"Passwords must be equals"]; break;
                    case MCShortPassword:       [self setErrorMessage:@"Min password length is 7"]; break;
                    default: break;
                }
            }
        }
    }
}

- (IBAction) disconnectTCPButton : (id) sender {

    if ([sender isKindOfClass:[UIButton class]]) {
        if ([sender isEqual:self.disconnectButton]) {
            [self->_client disconnectTCP];
        }
    }
}

- (MCInputError) isConnectionDataValid {

    NSString *username  = self.loginTextField.text;
    NSString *pass1     = self.passwordTextField.text;
    NSString *pass2     = self.confirmPasswordTextField.text;
    
    if (username.length == 0) {
        return MCNilLoginError;
    }
    
    if (pass1.length == 0 || pass2.length == 0) {
        return MCNilPasswordError;
    }
    
    if (![pass1 isEqualToString:pass2]) {
        return MCDifferentPassword;
    }
    
    if (pass1.length < MCMinPasswordLength || pass2.length < MCMinPasswordLength) {
        return MCShortPassword;
    }
    
    return MCWithoutError;
}

- (void) setErrorMessage : (NSString *) message {

    self.errorMessageLabel.text = message;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.errorMessageLabel.alpha = 1.0;
    }];
    
    [UIView animateWithDuration:4.0 delay:1.0 options:0 animations:^{
        self.errorMessageLabel.alpha = 0.0;
    } completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:MCDashboardSegue]) {
    
        MCDashboardViewController *controller = (MCDashboardViewController *)[segue destinationViewController];
        controller.client = self->_client;
        controller.helloString = [NSString stringWithFormat:@"Hello, %@!", self->_loginTextField.text];
    }
}

@end
