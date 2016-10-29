//
//  MCMessage.h
//  MqttIOSClient
//
//  Created by Anthony on 27.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

enum MCMessageType : Byte {
    
    MCReservedType      = 0,
    MCConnectType       = 1,
    MCConnackType       = 2,
    MCPublishType       = 3,
    MCPubackType        = 4,
    MCPubrecType        = 5,
    MCPubrelType        = 6,
    MCPubcompType       = 7,
    MCSubscribeType     = 8,
    MCSubackType        = 9,
    MCUnsubscribeType   = 10,
    MCUnsubackType      = 11,
    MCPingreqType       = 12,
    MCPingrespType      = 13,
    MCDisconnectType    = 14
};

@protocol MCMessage <NSObject>

- (NSInteger) getLength;
- (Byte) getMessageType;

@end
