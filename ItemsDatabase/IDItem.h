//
//  IDItem.h
//  ItemsDatabase
//
//  Created by ignacio mariani on 30/6/17.
//  Copyright © 2017 ignacio mariani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IDItem : NSObject

@property (strong, nonatomic) NSString *titulo;
@property (strong, nonatomic) NSString *subTitulo;
@property (assign, nonatomic) float precio;
@property (strong, nonatomic) NSString *descripcion;
@property (retain, nonatomic) UIImage *imagen;

- (id)initWithTitle:(NSString*)title withSubTitle:(NSString*)subT withPrice:(float)price withDescription:(NSString*)desc andImage:(UIImage*)img;

@end
