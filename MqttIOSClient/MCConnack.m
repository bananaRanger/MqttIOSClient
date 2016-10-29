//
//  MCConnack.m
//  MqttIOSClient
//
//  Created by Anthony on 29.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCConnack.h"

@implementation MCConnack

@synthesize sessionPresentValue = _sessionPresentValue;
@synthesize returnCode = _returnCode;

- (instancetype) initWithSessionPresentValue : (BOOL) sessionPresenValue andReturnCode : (MCConnectReturnCode) returnCode {

    self = [super init];
    if (self != nil) {
        self.sessionPresentValue = sessionPresenValue;
        self.returnCode = returnCode;
    }
    return self;
}

- (NSInteger) getLength {

    return 2;
}

- (Byte) getMessageType {
    
    return MCConnackType;
}

@end
