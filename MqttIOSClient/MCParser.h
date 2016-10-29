//
//  MCParser.h
//  MqttIOSClient
//
//  Created by Anthony on 25.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCLength.h"
#import "MCMessage.h"
#import "MCConnect.h"
#import "MCConnack.h"
#import "MCPingreq.h"
#import "MCPingresp.h"
#import "MCDisconnect.h"

@interface MCParser : NSObject

- (NSMutableData *) encode : (id<MCMessage>) message;
- (id<MCMessage>) decode : (NSMutableData *) buffer;

@end
