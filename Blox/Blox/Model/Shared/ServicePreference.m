//
//  ServicePreference.m
//  Blox
//
//  Created by Admin on 22/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ServicePreference.h"

@implementation ServicePreference

+(void)setObject:(NSString *)value andKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:value forKey:key];
    [userdefault synchronize];
}

+(NSString *)getObjectForKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSString *value = [userdefault objectForKey:key];
    return value;
}

+(void)setInteger:(NSInteger)value forKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setInteger:value forKey:key];
    [userdefault synchronize];
}

+(NSInteger)getIntegerForKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSInteger value = [userdefault integerForKey:key];
    return value;
}

+(void)setBool:(BOOL)status forKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setBool:status forKey:key];
    [userdefault synchronize];
}

+(BOOL)getBoolForKey:(NSString *)key{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    BOOL value = [userdefault boolForKey:key];
    return value;
    
}

@end
