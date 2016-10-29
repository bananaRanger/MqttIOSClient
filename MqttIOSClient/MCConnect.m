//
//  MCConnect.m
//  MqttIOSClient
//
//  Created by Anthony on 27.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCConnect.h"

static const Byte MCHeaderBytesLength = 10;

@implementation MCConnect

- (instancetype) init {

    self = [super init];
    if (self != nil) {
        self.username = nil;
        self.password = nil;
        self.clientID = @"543634";
    }
    return self;
}

- (NSInteger) getLength {

    NSInteger length = MCHeaderBytesLength;
    length += self.clientID.length + 2;
    length += 0;                                                        // Will
    length += [self isUsernameFlag] ? self.username.length + 2 : 0;
    length += [self isPasswordFlag] ? self.password.length + 2 : 0;
    return length;
}

- (Byte) getMessageType {
    
    return MCConnectType;
}

- (BOOL) isUsernameFlag {
    
    return self.username != nil;
}

- (BOOL) isPasswordFlag {
    
    return self.password != nil;
}

- (BOOL) isClientIDFlag {

    return self.clientID != nil;
}

- (BOOL) isClean {

    return self.cleanSession;
}

@end
