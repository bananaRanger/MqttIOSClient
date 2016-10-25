//
//  MQTT.h
//  MqttIOSClient
//
//  Created by Anthony on 18.10.16.
//  Copyright © 2016 AntonYereshchenko. All rights reserved.
//

#import "MCClientSocket.h"

@class MQTT;

@interface MQTT : NSObject <MCClientSocketDelegate>
{
    MCClientSocket *_socket;
}

- (void) connect;

- (void) disconnect;

@end
