//
//  ChatUser+CoreDataProperties.h
//  
//
//  Created by AnICoo1 on 2017/3/24.
//
//  This file was automatically generated and should not be edited.
//

#import "ChatUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ChatUser (CoreDataProperties)

+ (NSFetchRequest<ChatUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *chatText;
@property (nonatomic) BOOL youself;

@end

NS_ASSUME_NONNULL_END
