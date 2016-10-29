//
//  MQTT.h
//  MqttIOSClient
//
//  Created by Anthony on 18.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCClientSocket.h"
#import "MCTimingThread.h"
#import "MCParser.h"

@interface MQTT : NSObject <MCClientSocketDelegate, MCTimingThreadDelegate>
{
    MCClientSocket *_socket;
    MCParser *_parser;
    id<MCMessage> _message;
    BOOL _isConnect;
    MCTimingThread *_timingThread;
    NSThread *_thread;
}

@property (assign , nonatomic, readonly) BOOL isConnect;

- (void) connect : (id<MCMessage>) message;
- (void) disconnect;

- (void) disconnectTCP;

@end
