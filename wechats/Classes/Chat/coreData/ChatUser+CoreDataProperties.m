//
//  ChatUser+CoreDataProperties.m
//  
//
//  Created by AnICoo1 on 2017/3/24.
//
//  This file was automatically generated and should not be edited.
//

#import "ChatUser+CoreDataProperties.h"

@implementation ChatUser (CoreDataProperties)

+ (NSFetchRequest<ChatUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ChatUser"];
}

@dynamic chatText;
@dynamic youself;

@end
