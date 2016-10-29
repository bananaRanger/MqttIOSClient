//
//  MCPingresp.m
//  MqttIOSClient
//
//  Created by Anthony on 29.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCPingresp.h"

@implementation MCPingresp

- (NSInteger) getLength {
    return 0;
}

- (Byte) getMessageType {

    return MCPingrespType;
}

@end
