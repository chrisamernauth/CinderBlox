//
//  ServicePreference.h
//  Blox
//
//  Created by Admin on 22/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServicePreference : NSObject

+(void)setObject:(NSString *)value andKey:(NSString *)key;
+(NSString *)getObjectForKey:(NSString *)key;

+(void)setInteger:(NSInteger)value forKey:(NSString *)key;
+(NSInteger)getIntegerForKey:(NSString *)key;

+(void)setBool:(BOOL)status forKey:(NSString *)key;
+(BOOL)getBoolForKey:(NSString *)key;
@end
