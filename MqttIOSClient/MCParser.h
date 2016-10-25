//
//  MCParser.h
//  MqttIOSClient
//
//  Created by Anthony on 25.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

enum MCRequestType {

    MCReserved      = 0x00,
    MCConnect       = 0x10,
    MCConnack       = 0x20,
    MCPublish       = 0x30,
    MCPuback        = 0x40,
    MCPubrec        = 0x50,
    MCPubrel        = 0x60,
    MCPubcomp       = 0x70,
    MCSubscribe     = 0x80,
    MCSuback        = 0x90,
    MCUnsubscribe   = 0xA0,
    MCUnsuback      = 0xB0,
    MCPingreq       = 0xC0,
    MCPingreso      = 0xD0,
    MCDisconnect    = 0xE0
};

@interface MCParser : NSObject

- (NSDictionary *) parseData : (NSData *) data;

@end
