//
//  MCDisconnect.m
//  MqttIOSClient
//
//  Created by Anthony on 27.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCDisconnect.h"

@implementation MCDisconnect

- (NSInteger) getLength {

    return 0;
}

- (Byte)getMessageType {

    return MCDisconnectType;
}

@end
