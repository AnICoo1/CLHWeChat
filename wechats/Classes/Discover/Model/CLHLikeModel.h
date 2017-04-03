//
//  CLHLikeModel.h
//  wechats
//
//  Created by AnICoo1 on 17/2/25.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHLikeModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic, copy) NSAttributedString *attributedContent;


+ (instancetype)likeModelWithName:(NSString *)name;

@end
