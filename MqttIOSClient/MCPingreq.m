//
//  MCPingreq.m
//  MqttIOSClient
//
//  Created by Anthony on 29.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCPingreq.h"

@implementation MCPingreq

- (NSInteger) getLength {
    return 0;
}

- (Byte) getMessageType {
    
    return MCPingreqType;
}

@end
