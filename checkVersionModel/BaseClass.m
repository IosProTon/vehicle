//
//  BaseClass.m
//
//  Created by   on 15/8/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"
#import "Data.h"


NSString *const kBaseClassMsg = @"msg";
NSString *const kBaseClassRc = @"rc";
NSString *const kBaseClassData = @"data";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize msg = _msg;
@synthesize rc = _rc;
@synthesize data = _data;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.msg = [self objectOrNilForKey:kBaseClassMsg fromDictionary:dict];
            self.rc = [[self objectOrNilForKey:kBaseClassRc fromDictionary:dict] doubleValue];
            self.data = [Data modelObjectWithDictionary:[dict objectForKey:kBaseClassData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.msg forKey:kBaseClassMsg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rc] forKey:kBaseClassRc];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kBaseClassData];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.msg = [aDecoder decodeObjectForKey:kBaseClassMsg];
    self.rc = [aDecoder decodeDoubleForKey:kBaseClassRc];
    self.data = [aDecoder decodeObjectForKey:kBaseClassData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_msg forKey:kBaseClassMsg];
    [aCoder encodeDouble:_rc forKey:kBaseClassRc];
    [aCoder encodeObject:_data forKey:kBaseClassData];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.msg = [self.msg copyWithZone:zone];
        copy.rc = self.rc;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
