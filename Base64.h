//
//  Base64.h
//  AttendanceManagement
//
//  Created by Welltime on 21/01/2015.
//  Copyright (c) 2015 Welltime. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Base64 : NSObject {
    
}

+ (void) initialize;

+ (NSString*) encode:(const uint8_t*) input length:(NSInteger) length;

+ (NSString*) encode:(NSData*) rawBytes;

+ (NSData*) decode:(const char*) string length:(NSInteger) inputLength;

+ (NSData*) decode:(NSString*) string;

@end
