//
//  MQTT.m
//  MqttIOSClient
//
//  Created by Anthony on 18.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MQTT.h"

@implementation MQTT

- (instancetype) init {

    self = [super init];
    if (self != nil) {
    
        self->_socket = [[MCClientSocket alloc] init];
        self->_socket.delegate = self;
    }
    return self;
}

- (void) connect {

    if (self->_socket.isStart == false) {
        [self->_socket start];
    } else {
        [self->_socket stop];
    }
}

- (void) disconnect {

    if (self->_socket.isStart == true) {
        [self->_socket stop];
    }
}

- (void) socket : (MCClientSocket *) clientSocket didConnectToAddress : (NSString *) address port : (NSInteger) port {
    NSLog(@"CONNECT TO : %@ , port - %li", address, port);
}

- (void) socket:(MCClientSocket *) clientSocket didDisconnectFromAddress : (NSString *) address port : (NSInteger) port {
    NSLog(@"DISCONNECT FROM : %@ , port - %li", address, port);
}

- (void) socket : (MCClientSocket *) clientSocket didReadData   : (NSString *) data {
    NSLog(@"didReadData : %@", data);
}

- (void) socket : (MCClientSocket *) clientSocket didWriteData  : (NSString *) data {
    NSLog(@"didWriteData : %@", data);
}

- (void) socket : (MCClientSocket *) clientSocket socketError   : (enum MCClientError) error {
    NSLog(@"socketError");
}

@end
