//
//  MCClient.m
//  MqttIOSClient
//
//  Created by Anthony on 21.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCClientSocket.h"

static const int MCBufferSize = 2048;
static const double MCConnectionTimeout = 10.0f;

@implementation MCClientSocket

@synthesize delegate = _delegate;
@synthesize isStart = _isStart;

- (instancetype) init {

    self = [super init];
    if (self != nil) {
        self->_settings = [MCSettings sharedInstance];
        self->_descriptor = 0;
        self->_isStart = false;
    }
    return self;
}

- (void) start {
    
    self->_socket = CFSocketCreate(
                                        kCFAllocatorDefault,
                                        PF_INET,                // Protocol Family
                                        SOCK_STREAM,            // Soket Type
                                        IPPROTO_TCP,            // Protocol
                                        0,                      // CallBackTypes
                                        NULL,                   // CFSocketCallBack
                                        NULL                    // CFSocketContext
                                        );
    
    struct sockaddr_in sin;
    
    memset(&sin, 0, sizeof(sin));
    sin.sin_len         = AF_INET;
    sin.sin_port        = htons(self->_settings.port);
    
    sin.sin_addr.s_addr = [self->_settings getIPAddress];
    
    CFDataRef sincfd = CFDataCreate(kCFAllocatorDefault, (UInt8 *)&sin, sizeof(sin));
    
    CFSocketError error = CFSocketConnectToAddress(self->_socket, sincfd, MCConnectionTimeout);
    
    CFRelease(sincfd);
    
    if (error == kCFSocketError) {
        NSLog(@"Ошибка соединения с удаленным сервером");
        [self.delegate socket:self socketError:MCSocketConnectionError];
        return;
    }
    if (error == kCFSocketTimeout) {
        NSLog(@"Таймаут соединения с удаленным сервером");
        [self.delegate socket:self socketError:MCSocketTimeoutError];
        return;
    }
    
    self->_descriptor = CFSocketGetNative(self->_socket);
    
    NSLog(@"Установление соединения с сервером произошло успешно");
    [self.delegate socket:self didConnectToAddress:self->_settings.address port:self->_settings.port];
    
    self->_isStart = true;
}

- (void) stop {

    close(self->_descriptor);
    [self.delegate socket:self didDisconnectFromAddress:self->_settings.address port:self->_settings.port];
    self->_isStart = false;
}

- (void) requestToServer : (NSString *) data {
        
    char readBuffer[MCBufferSize];
    const char *writeBuffer = [data cStringUsingEncoding:NSUTF8StringEncoding];
    
    if (strlen(writeBuffer) == 0) {
        [self.delegate socket:self socketError:MCInvalidRequestData];
        return;
    }
    
    ssize_t count = write(self->_descriptor, writeBuffer, strlen(writeBuffer));
    if (count <= 0) {
        [self.delegate socket:self socketError:MCReadDataError];
        return;
    } else {
        [self.delegate socket:self didWriteData:data];
    }
    
    count = read(self->_descriptor, readBuffer, MCBufferSize);
    if (count <= 0) {
        [self.delegate socket:self socketError:MCWriteDataError];
        return;
    }
    
    readBuffer[count] = 0;
    
    NSString *answer = [NSString stringWithCString:readBuffer encoding:NSUTF8StringEncoding];
    
    [self.delegate socket:self didReadData:answer];
}

@end
