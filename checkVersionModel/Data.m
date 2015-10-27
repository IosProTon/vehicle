//
//  Data.m
//
//  Created by   on 15/8/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Data.h"


NSString *const kDataVersionNo = @"versionNo";
NSString *const kDataCreateTime = @"createTime";
NSString *const kDataId = @"id";
NSString *const kDataModTime = @"modTime";
NSString *const kDataIsNewestVer = @"isNewestVer";
NSString *const kDataIsUseful = @"isUseful";
NSString *const kDataSessionId = @"sessionId";
NSString *const kDataPath = @"path";
NSString *const kDataDes = @"des";
NSString *const kDataSysType = @"sysType";


@interface Data ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Data

@synthesize versionNo = _versionNo;
@synthesize createTime = _createTime;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize modTime = _modTime;
@synthesize isNewestVer = _isNewestVer;
@synthesize isUseful = _isUseful;
@synthesize sessionId = _sessionId;
@synthesize path = _path;
@synthesize des = _des;
@synthesize sysType = _sysType;


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
            self.versionNo = [self objectOrNilForKey:kDataVersionNo fromDictionary:dict];
            self.createTime = [self objectOrNilForKey:kDataCreateTime fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kDataId fromDictionary:dict] doubleValue];
            self.modTime = [self objectOrNilForKey:kDataModTime fromDictionary:dict];
            self.isNewestVer = [[self objectOrNilForKey:kDataIsNewestVer fromDictionary:dict] doubleValue];
            self.isUseful = [[self objectOrNilForKey:kDataIsUseful fromDictionary:dict] doubleValue];
            self.sessionId = [self objectOrNilForKey:kDataSessionId fromDictionary:dict];
            self.path = [self objectOrNilForKey:kDataPath fromDictionary:dict];
            self.des = [self objectOrNilForKey:kDataDes fromDictionary:dict];
            self.sysType = [[self objectOrNilForKey:kDataSysType fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.versionNo forKey:kDataVersionNo];
    [mutableDict setValue:self.createTime forKey:kDataCreateTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kDataId];
    [mutableDict setValue:self.modTime forKey:kDataModTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isNewestVer] forKey:kDataIsNewestVer];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isUseful] forKey:kDataIsUseful];
    [mutableDict setValue:self.sessionId forKey:kDataSessionId];
    [mutableDict setValue:self.path forKey:kDataPath];
    [mutableDict setValue:self.des forKey:kDataDes];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sysType] forKey:kDataSysType];

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

    self.versionNo = [aDecoder decodeObjectForKey:kDataVersionNo];
    self.createTime = [aDecoder decodeObjectForKey:kDataCreateTime];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kDataId];
    self.modTime = [aDecoder decodeObjectForKey:kDataModTime];
    self.isNewestVer = [aDecoder decodeDoubleForKey:kDataIsNewestVer];
    self.isUseful = [aDecoder decodeDoubleForKey:kDataIsUseful];
    self.sessionId = [aDecoder decodeObjectForKey:kDataSessionId];
    self.path = [aDecoder decodeObjectForKey:kDataPath];
    self.des = [aDecoder decodeObjectForKey:kDataDes];
    self.sysType = [aDecoder decodeDoubleForKey:kDataSysType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_versionNo forKey:kDataVersionNo];
    [aCoder encodeObject:_createTime forKey:kDataCreateTime];
    [aCoder encodeDouble:_dataIdentifier forKey:kDataId];
    [aCoder encodeObject:_modTime forKey:kDataModTime];
    [aCoder encodeDouble:_isNewestVer forKey:kDataIsNewestVer];
    [aCoder encodeDouble:_isUseful forKey:kDataIsUseful];
    [aCoder encodeObject:_sessionId forKey:kDataSessionId];
    [aCoder encodeObject:_path forKey:kDataPath];
    [aCoder encodeObject:_des forKey:kDataDes];
    [aCoder encodeDouble:_sysType forKey:kDataSysType];
}

- (id)copyWithZone:(NSZone *)zone
{
    Data *copy = [[Data alloc] init];
    
    if (copy) {

        copy.versionNo = [self.versionNo copyWithZone:zone];
        copy.createTime = [self.createTime copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.modTime = [self.modTime copyWithZone:zone];
        copy.isNewestVer = self.isNewestVer;
        copy.isUseful = self.isUseful;
        copy.sessionId = [self.sessionId copyWithZone:zone];
        copy.path = [self.path copyWithZone:zone];
        copy.des = [self.des copyWithZone:zone];
        copy.sysType = self.sysType;
    }
    
    return copy;
}


@end
