//
//  MCSettings.h
//  MqttIOSClient
//
//  Created by Anthony on 21.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface MCSettings : NSObject <NSCoding>
{
    NSString *_address;
    NSInteger _port;
}

@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) NSInteger port;

+ (instancetype) sharedInstance;

- (unsigned int) getIPAddress;

- (void) save;
- (void) load;

@end
