//
//  MCTimingThread.h
//  MqttIOSClient
//
//  Created by Anthony on 29.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -MCTimingThreadDelegate-

@protocol MCTimingThreadDelegate <NSObject>

- (void) timeDidPass;

@end

#pragma mark -MCTimingThread-

@interface MCTimingThread : NSObject
{
    __weak id<MCTimingThreadDelegate> _delegate;
}

@property (assign, nonatomic) double interval;
@property (weak, nonatomic) id<MCTimingThreadDelegate> delegate;

- (void) runMethod : (NSObject *) object;

@end
