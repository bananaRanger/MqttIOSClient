//
//  MCLength.m
//  MqttIOSClient
//
//  Created by Anthony on 29.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCLength.h"

@implementation MCLength

@synthesize length = _length;
@synthesize size = _size;

- (instancetype) initWithLength : (NSInteger) length andSize : (NSInteger) size {

    self = [super init];
    if (self != nil) {
        self->_length = length;
        self->_size = size;
    }
    return self;
}

@end
