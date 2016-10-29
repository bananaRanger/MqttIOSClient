//
//  MCConnect.h
//  MqttIOSClient
//
//  Created by Anthony on 27.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCMessage.h"

static NSInteger const MCProtocolLevel = 4;
static NSString *const MCProtocolName  = @"MQTT";

@interface MCConnect : NSObject <MCMessage>

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *clientID;

@property (assign, nonatomic) BOOL cleanSession;
@property (assign, nonatomic) NSInteger keepAlive;

- (BOOL) isUsernameFlag;
- (BOOL) isPasswordFlag;
- (BOOL) isClientIDFlag;

- (BOOL) isClean;

@end
