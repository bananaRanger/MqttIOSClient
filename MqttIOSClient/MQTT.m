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
        
        self->_parser = [[MCParser alloc] init];
        
        self->_timingThread = [[MCTimingThread alloc] init];
        self->_timingThread.delegate = self;
    }
    return self;
}

- (void) connect : (id<MCMessage>) message {

    if (self->_socket.isStart == false) {
        self->_message = message;
        [self->_socket start];
    } else {
        [self closeConnection];
    }
}

- (void) disconnect {

    if (self->_socket.isStart == true) {
        [self closeConnection];
    }
}

- (void) closeConnection {

    [self->_thread cancel];
    
    MCDisconnect *disconnect = [[MCDisconnect alloc] init];
    NSMutableData *data = [self->_parser encode:disconnect];
    [self->_socket requestToServer:data];
}

- (void) disconnectTCP {

    if (self->_socket.isStart == true) {
        [self->_socket stop];
    }
}



#pragma mark -MCClientSocketDelegate-


- (void) timeDidPass {

    MCPingreq *ping = [[MCPingreq alloc] init];
    NSMutableData *data = [self->_parser encode:ping];
    [self->_socket requestToServer:data];
}



#pragma mark -MCClientSocketDelegate-



- (void) socket : (MCClientSocket *) clientSocket didConnectToAddress : (NSString *) address port : (NSInteger) port {
    NSLog(@"CONNECT TO : %@ , port - %li", address, port);
    
    MCParser *parser = [[MCParser alloc] init];
    NSMutableData *data = [parser encode:self->_message];
    [self->_socket requestToServer:data];
}

- (void) socket:(MCClientSocket *) clientSocket didDisconnectFromAddress : (NSString *) address port : (NSInteger) port {
    NSLog(@"DISCONNECT FROM : %@ , port - %li", address, port);
}

- (void) socket : (MCClientSocket *) clientSocket didReadData   : (NSMutableData *) data {
    NSLog(@"didReadData : %@", data);
    
    MCParser *parser = [[MCParser alloc] init];
    self->_message = [parser decode:data];
    
    if ([self->_message getMessageType] == MCConnackType) {
        MCConnack *connack = (MCConnack *)self->_message;
        
        if (connack.returnCode == MCAccepted) {
            self->_timingThread.interval = 10.0;
            self->_thread = [[NSThread alloc] initWithTarget:self->_timingThread selector:@selector(runMethod:) object:nil];
            [self->_thread start];
        }
    }
    
    NSLog(@"TYPE = %hhu", [self->_message getMessageType]);
}

- (void) socket : (MCClientSocket *) clientSocket didWriteData  : (NSMutableData *) data {
    NSLog(@"didWriteData : %@", data);

}

- (void) socket : (MCClientSocket *) clientSocket socketError   : (MCClientError) error {
    NSLog(@"socketError");
}

@end
