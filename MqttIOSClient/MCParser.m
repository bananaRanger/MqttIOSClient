//
//  MCParser.m
//  MqttIOSClient
//
//  Created by Anthony on 25.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCParser.h"

@implementation NSMutableData (MQTT)

NSInteger byteNumber = 0;

- (void) appendByte : (Byte) byte {
    
    [self appendBytes:&byte length:1];
}

- (Byte) readByte {
    
    const Byte *bytes = [self bytes];
    Byte byte = bytes[byteNumber];
    byteNumber++;
    
    return byte;
}

- (NSString *) readStringWithLength : (NSInteger) length {
    
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        
        char chr = (char)[self readByte];
        [string appendFormat:@"%c", chr];
    }
    return string;
}

- (void) clearNumber {
    byteNumber = 0;
}

@end

@implementation MCParser

- (NSMutableData *) encode : (id<MCMessage>) message {

    NSInteger length = [message getLength];
    NSMutableData *buffer = [NSMutableData data];
    Byte messageType = [message getMessageType];
    
    if (messageType == MCConnectType) {

        MCConnect *connect = (MCConnect *)message;
       
        [buffer appendByte:(messageType << 4)];

        [buffer appendData:[self encodedLength:length]];

        [buffer appendByte:0];
        [buffer appendByte:4];
        
        [buffer appendData:[MCProtocolName dataUsingEncoding:NSUTF8StringEncoding]];
        
        [buffer appendByte:MCProtocolLevel];
        
        Byte contentFlags = 0;
        contentFlags |= 0;                                  // Reserved
        contentFlags |= [connect isClean];                  // Clean session
        contentFlags |= 0;                                  // Will
        contentFlags |= 0;                                  // QOS
        contentFlags |= 0;                                  // Retain
        contentFlags |= [connect isUsernameFlag] ? 0x40 : 0;
        contentFlags |= [connect isPasswordFlag] ? 0X80 : 0;
        
        [buffer appendByte:contentFlags];
        
        [buffer appendByte:0];
        [buffer appendByte:10];
        
        [buffer appendByte:0];
        [buffer appendByte:connect.clientID.length];
        [buffer appendData:[connect.clientID dataUsingEncoding:NSUTF8StringEncoding]];

        if (connect.username != nil) {
            [buffer appendByte:0];
            [buffer appendByte:connect.username.length];
            [buffer appendData:[connect.username dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        if (connect.password != nil) {
            [buffer appendByte:0];
            [buffer appendByte:connect.password.length];
            [buffer appendData:[connect.password dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
    } else if (messageType == MCConnackType) {
        
        MCConnack *connack = (MCConnack *)message;
        [buffer appendByte:(messageType << 4)];
        [buffer appendByte:(Byte)connack.sessionPresentValue];
        [buffer appendByte:(Byte)connack.returnCode];
        
    } else if (messageType == MCPingreqType || messageType == MCPingrespType || messageType == MCDisconnectType) {
    
        [buffer appendByte:(messageType << 4)];
        [buffer appendData:[self encodedLength:length]];
        
    } else {
        NSLog(@"\n\n\n E: UNKNOWN TYPE! \n\n\n");
    }
   
    [buffer clearNumber];
    
    return buffer;
}

- (id<MCMessage>) decode : (NSMutableData *) buffer {

    id<MCMessage> message = nil;
    
    Byte fixedHeader = [buffer readByte];
    Byte messageType = ((fixedHeader >> 4) & 0xf);
    
    MCLength *length = [self decodeLength:buffer];
    
    if (messageType == MCConnectType) {
    
        [buffer readByte];                                          // read Length MSB (0)
        NSInteger protocolNameLength = [buffer readByte];
        NSString *protocolName = [buffer readStringWithLength : protocolNameLength];
        
        if (![protocolName isEqualToString:MCProtocolName]) {
            @throw [NSException exceptionWithName:@"CONNECT" reason:[NSString stringWithFormat:@"Protocol is %@", protocolName] userInfo:nil];
        }
        
        NSInteger protocolLevel = [buffer readByte];
        
        Byte contentFlags = [buffer readByte];
        
        BOOL usernameFlag       = (((contentFlags >> 7) & 1) == 1) ? true : false;
        BOOL userPasswordFlag   = (((contentFlags >> 6) & 1) == 1) ? true : false;
        BOOL willRetainFlag     = (((contentFlags >> 5) & 1) == 1) ? true : false;
        BOOL willQoSFlag        = ((((contentFlags & 0x1f) >> 3) & 3) == 1) ? true : false;
        BOOL willFlag           = (((contentFlags >> 2) & 1) == 1) ? true : false;
        BOOL cleanSessionFlag   = (((contentFlags >> 1) & 1) == 1) ? true : false;
        BOOL reservedFlag       = ((contentFlags  & 1) == 1) ? true : false;
        
        /*
        NSLog(@"User name flag      = %@", usernameFlag ? @"yes" : @"no");
        NSLog(@"User password flag  = %@", userPasswordFlag ? @"yes" : @"no");
        NSLog(@"Will retain flag    = %@", willRetainFlag ? @"yes" : @"no");
        NSLog(@"User qos flag       = %@", willQoSFlag ? @"yes" : @"no");
        NSLog(@"User flag           = %@", willFlag ? @"yes" : @"no");
        NSLog(@"Clean session flag  = %@", cleanSessionFlag ? @"yes" : @"no");
        NSLog(@"Reserved flag       = %@", reservedFlag ? @"yes" : @"no");
        */
        
        if (reservedFlag == true) {
            @throw [NSException exceptionWithName:@"CONNECT" reason:@"Reserved flag set to true" userInfo:nil];
        }
        
        [buffer readByte];                                          // read Keep Alive MSB (0)
        NSInteger keepAlive = [buffer readByte];

        [buffer readByte];                                          // read Length MSB (0)
        NSInteger cliendIDLength = [buffer readByte];
        NSString *clientID = [buffer readStringWithLength:cliendIDLength];
        
        NSString *username = [NSString string];
        NSString *password = [NSString string];
        
        if (usernameFlag == true) {
        
            [buffer readByte];                                      // read Length MSB (0)
            NSInteger usernameLength = [buffer readByte];
            username = [buffer readStringWithLength:usernameLength];
        }
        
        if (userPasswordFlag == true) {
        
            [buffer readByte];                                      // read Length MSB (0)
            NSInteger passwordLength = [buffer readByte];
            password = [buffer readStringWithLength:passwordLength];
        }
        
        MCConnect *connect = [[MCConnect alloc] init];
        connect.username = username;
        connect.password = password;
        connect.clientID = clientID;
        connect.cleanSession = cleanSessionFlag;
        connect.keepAlive = keepAlive;
        
        message = connect;
        
    } else if (messageType == MCConnackType) {
    
        Byte sessionPresentValue = [buffer readByte];
        BOOL isPresent = (sessionPresentValue == 1) ? true : false;
        Byte connectReturnCode = [buffer readByte];
        
        message = [[MCConnack alloc] initWithSessionPresentValue:isPresent andReturnCode:connectReturnCode];
                
    } else if (messageType == MCPingreqType) {

        message = [[MCPingreq alloc] init];
        
    } else if (messageType == MCPingrespType) {
        
        message = [[MCPingresp alloc] init];
        
    } else if (messageType == MCDisconnectType) {
    
        message = [[MCDisconnect alloc] init];
        
    } else {
        NSLog(@"\n\n\n D: UNKNOWN TYPE! \n\n\n");
    }
    
    [buffer clearNumber];
    
    return message;
}

- (NSMutableData *) encodedLength : (NSInteger) length {

    NSMutableData *data = [NSMutableData data];
    NSInteger lng = length;
    Byte encodedByte;
    
    do {
    
        encodedByte = (Byte)(lng % 128);
        lng /= 128;
        
        if (lng > 0) {
            [data appendByte:(Byte)(encodedByte | 128)];
        } else {
            [data appendByte:encodedByte];
        }
        
    } while (lng > 0);
    
    NSInteger bufferSize = 1 + data.length + length;
    NSMutableData *buffer = [NSMutableData dataWithCapacity:bufferSize];
    
    [buffer appendData:data];
    
    return buffer;
}

- (MCLength *) decodeLength : (NSMutableData *) buffer {

    NSInteger length = 0;
    NSInteger multiplier = 1;
    NSInteger byteUsed = 0;
    Byte encodedByte = 0;
    
    do {
        if (!(multiplier > 128 * 128 * 128)) {
        
            encodedByte = [buffer readByte];
            length += (encodedByte & 0x7f) * multiplier;
            multiplier *= 128;
            byteUsed++;
        }
    } while ((encodedByte & 128) != 0);
    
    return [[MCLength alloc] initWithLength:length andSize:byteUsed];
}

@end

