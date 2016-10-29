//
//  MCTimingThread.m
//  MqttIOSClient
//
//  Created by Anthony on 29.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCTimingThread.h"

@implementation MCTimingThread

@synthesize delegate = _delegate;

- (void) runMethod : (NSObject *) object {

    while ([NSThread currentThread].isCancelled == false) {
        [NSThread sleepForTimeInterval:self.interval];
        [self->_delegate timeDidPass];
    }
}

@end
