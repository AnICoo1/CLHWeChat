//
//  CLHMessage.h
//  wechats
//
//  Created by AnICoo1 on 17/2/21.
//  Copyright © 2017年 AnICoo1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLHMessage : NSObject

@property (nonatomic,copy) NSString *messageText;

@property (nonatomic,assign,getter=isYouself) BOOL youself;

@end
