//
//  IDSavingManager.m
//  ItemsDatabase
//
//  Created by ignacio mariani on 4/7/17.
//  Copyright © 2017 ignacio mariani. All rights reserved.
//

#import "IDSavingManager.h"
#import "IDItem.h"
#import "IDUtilities.h"

@interface IDSavingManager ()

@property (strong, nonatomic) NSMutableArray *arrayOfItems;

@end

@implementation IDSavingManager

+ (id)sharedInstance {
    static IDSavingManager *sharedSavingManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSavingManager = [[self alloc] init];
    });
    return sharedSavingManager;
}

- (id)init {
    if (self = [super init])
    {
        _arrayOfItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) setNewDelegate:(id)newDelegate
{
    self.delegate = newDelegate;
}

- (void)saveItem:(IDItem *) item
{
    [self updateStoredItemsWithItem:item];
    
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:self.arrayOfItems.count];
    for (IDItem *item in self.arrayOfItems)
    {
        NSData *itemEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:item];
        [archiveArray addObject:itemEncodedObject];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:archiveArray forKey:@"itemsArray"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.delegate notifyItemSavedSuccessfully];
}

- (void)showItemsSaved
{
    NSArray *itemsDecoded = [self decodeItemsFromArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"itemsArray"]];
    
    for(IDItem *itemDecoded in itemsDecoded)
    {
        NSLog(@"*****************");
        NSLog(@"Título: %@", itemDecoded.titulo);
        NSLog(@"Subtítulo: %@", itemDecoded.subTitulo);
        NSLog(@"Precio: %@", [IDUtilities formatDecimalFromFloat:itemDecoded.precio]);
        NSLog(@"Descripción: %@", itemDecoded.descripcion);
    }
}

- (void)updateStoredItemsWithItem:(IDItem *)item
{
    NSArray *items = [[NSUserDefaults standardUserDefaults] arrayForKey:@"itemsArray"];
    
    if (items)
    {
        self.arrayOfItems = [self decodeItemsFromArray:items];
    }
    
    [self.arrayOfItems addObject:item];
}

- (NSMutableArray *)decodeItemsFromArray:(NSArray *)itemsSaved
{
    NSMutableArray *itemsDecoded = [[NSMutableArray alloc] init];
    
    for(NSData *itemEncoded in itemsSaved)
    {
        IDItem *itemDecoded = [NSKeyedUnarchiver unarchiveObjectWithData:itemEncoded];
        [itemsDecoded addObject:itemDecoded];
    }
    
    return itemsDecoded;
}



@end
