//
//  ZMAXLocationRecommendAnalysisModel.m
//  Zmax
//
//  Created by 杨杰 on 2021/3/22.
//

#import "ZMAXLocationRecommendAnalysisModel.h"

@interface ZMAXLocationRecommendAnalysisModel ()

@end

@implementation ZMAXLocationRecommendAnalysisModel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [self init];
    if (self) {
        self.ID = [coder decodeObjectForKey:@"ID"];
        self.time = [coder decodeObjectForKey:@"time"];
        self.city = [coder decodeObjectForKey:@"city"];
        self.industry = [coder decodeObjectForKey:@"industry"];
        self.imageUrl = [coder decodeObjectForKey:@"imageUrl"];
        NSData *data = [coder decodeObjectForKey:@"analysisArrayData"];
        self.analysisArray = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSArray class]
                                                               fromData:data
                                                                  error:nil];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.ID forKey:@"ID"];
    [coder encodeObject:self.time forKey:@"time"];
    [coder encodeObject:self.city forKey:@"city"];
    [coder encodeObject:self.industry forKey:@"industry"];
    [coder encodeObject:self.imageUrl forKey:@"imageUrl"];
    NSData *data = [[NSKeyedArchiver archivedDataWithRootObject:self.analysisArray
                                          requiringSecureCoding:YES
                                                          error:nil] copy];
    [coder encodeObject:data forKey:@"analysisArrayData"];
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

@end
