//
//  IDSavingManager.h
//  ItemsDatabase
//
//  Created by ignacio mariani on 4/7/17.
//  Copyright © 2017 ignacio mariani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDItem.h"

@protocol SaveItemDelegate <NSObject>

-(void)notifyItemSavedSuccessfully;

@end

@interface IDSavingManager : NSObject

@property (strong, nonatomic) id<SaveItemDelegate> delegate;

+(id)sharedInstance;
-(void)setNewDelegate:(id)newDelegate;
-(void)saveItem:(IDItem *) item;
-(void)showItemsSaved;

@end
