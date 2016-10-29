//
//  MCConnack.h
//  MqttIOSClient
//
//  Created by Anthony on 29.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCMessage.h"

typedef enum {
    MCAccepted                      = 0,
    MCUnacceptableProtocolVersion   = 1,
    MCIdentifierRejected            = 2,
    MCServerUnavaliable             = 3,
    MCBadUserOrPass                 = 4,
    MCNotAuthorized                 = 5
} MCConnectReturnCode;

@interface MCConnack : NSObject <MCMessage>
{
    BOOL _sessionPresentValue;
    MCConnectReturnCode _returnCode;
}

@property (assign, nonatomic) BOOL sessionPresentValue;
@property (assign, nonatomic) MCConnectReturnCode returnCode;

- (instancetype) initWithSessionPresentValue : (BOOL) sessionPresenValue andReturnCode : (MCConnectReturnCode) returnCode;

@end
