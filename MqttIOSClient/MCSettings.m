//
//  MCSettings.m
//  MqttIOSClient
//
//  Created by Anthony on 21.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCSettings.h"

static NSString *const MCAddressKey         = @"MCAddressKey";
static NSString *const MCPortKey            = @"MCPortKey";
static NSString *const MCSettingsFileName   = @"mcsettings.dat";
static NSInteger const MCCapacity           = 1024;

@implementation MCSettings

@synthesize address = _address;
@synthesize port    = _port;

+ (instancetype) sharedInstance {
    
    static MCSettings *settings = nil;
    @synchronized (self) {
        if (settings == nil) {
            settings = [[self alloc] init];
        }
    }
    return settings;
}

- (instancetype) init {
    self = [super init];
    if (self != nil) {
        
        self->_address = [NSString stringWithFormat:@"198.41.30.241"];
        self->_port = 1883;
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        self->_address = [aDecoder decodeObjectForKey:MCAddressKey];
        self->_port = [aDecoder decodeIntegerForKey:MCPortKey];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self->_address forKey:MCAddressKey];
    [aCoder encodeInteger:self->_port forKey:MCPortKey];
}


- (unsigned int) getIPAddress {
    
    unsigned int ipAddress = 0;
    
    if (self->_address != nil) {
        NSArray *array = [self->_address componentsSeparatedByString:@"."];
        if (array.count == 4) {
            ipAddress = [[array objectAtIndex:3] intValue] << 24 |
            [[array objectAtIndex:2] intValue] << 16 |
            [[array objectAtIndex:1] intValue] << 8  |
            [[array objectAtIndex:0] intValue];
        }
    }
    return ipAddress;
}

- (void) save {

    NSMutableData *data = [NSMutableData dataWithCapacity:MCCapacity];
    NSKeyedArchiver *encoder = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    MCSettings *settings = self;
    
    [encoder encodeObject:settings];
    [encoder finishEncoding];
    
    [data writeToFile:[self settingsFileName] atomically:false];
}

- (void) load {

    NSMutableData *data = [NSMutableData dataWithContentsOfFile:[self settingsFileName]];
    if (data.length != 0) {
        MCSettings *settings = self;
        NSKeyedUnarchiver *decoder = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSMutableArray    *array   = [[NSMutableArray alloc] init];
        MCSettings *temp = [MCSettings sharedInstance];
        
        BOOL flag = true;
        while (flag) {
            temp = [decoder decodeObject];
            if (temp != nil) {
                [array addObject:temp];
            } else {
                flag = false;
            }
        }
        settings->_address  = ((MCSettings *)[array firstObject])->_address;
        settings->_port     = ((MCSettings *)[array firstObject])->_port;
    }
}

- (NSString *) settingsFileName {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:MCSettingsFileName];

    return path;
}


@end
