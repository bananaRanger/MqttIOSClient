//
//  MCLength.h
//  MqttIOSClient
//
//  Created by Anthony on 29.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCLength : NSObject
{
    NSInteger _length;
    NSInteger _size;
}

@property (assign, nonatomic) NSInteger length;
@property (assign, nonatomic) NSInteger size;

- (instancetype) initWithLength : (NSInteger) length andSize : (NSInteger) size;

@end
