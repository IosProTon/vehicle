//
//  Data.h
//
//  Created by   on 15/8/17
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Data : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *versionNo;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, strong) NSString *modTime;
@property (nonatomic, assign) double isNewestVer;
@property (nonatomic, assign) double isUseful;
@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, assign) double sysType;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
