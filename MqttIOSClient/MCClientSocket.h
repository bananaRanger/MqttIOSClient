//
//  MCClientSocket.h
//  MqttIOSClient
//
//  Created by Anthony on 21.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCSettings.h"
#import <sys/socket.h>
#import <netinet/in.h>

@class MCClientSocket;

#pragma mark -MCClientError-

typedef enum {
    MCSocketConnectionSuccess   = 0,
    MCSocketConnectionError     = 1,
    MCSocketTimeoutError        = 2,
    MCReadDataError             = 3,
    MCWriteDataError            = 4,
    MCInvalidRequestData        = 5
} MCClientError;

#pragma mark -MCClientSocketDelegate-

@protocol MCClientSocketDelegate <NSObject>
- (void) socket : (MCClientSocket *) clientSocket didConnectToAddress       : (NSString *) address port : (NSInteger) port;
- (void) socket : (MCClientSocket *) clientSocket didDisconnectFromAddress  : (NSString *) address port : (NSInteger) port;
- (void) socket : (MCClientSocket *) clientSocket didReadData   : (NSMutableData *) data;
- (void) socket : (MCClientSocket *) clientSocket didWriteData  : (NSMutableData *) data;
- (void) socket : (MCClientSocket *) clientSocket socketError   : (MCClientError) error;
@end

#pragma mark -MCClientSocket-

@interface MCClientSocket : NSObject
{
    MCSettings *_settings;
    CFSocketRef _socket;
    int _descriptor;
    BOOL _isStart;
    __weak id<MCClientSocketDelegate> _delegate;
}

@property (weak, nonatomic) id<MCClientSocketDelegate> delegate;
@property (assign , nonatomic, readonly) BOOL isStart;

- (void) start;
- (void) stop;

- (void) requestToServer : (NSMutableData *) data;

@end
