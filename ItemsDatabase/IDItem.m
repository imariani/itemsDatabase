//
//  IDItem.m
//  ItemsDatabase
//
//  Created by ignacio mariani on 30/6/17.
//  Copyright © 2017 ignacio mariani. All rights reserved.
//

#import "IDItem.h"

@interface IDItem () <NSCoding>



@end


@implementation IDItem

- (id)initWithTitle:(NSString*)title withSubTitle:(NSString*)subT withPrice:(float)price withDescription:(NSString*)desc andImage:(UIImage*)img
{
    if (self = [super init])
    {
        _titulo = title;
        _subTitulo = subT;
        _descripcion = desc;
        _precio = price;
        _imagen = img;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        _titulo = [aDecoder decodeObjectForKey:@"TITULO_KEY"];
        _subTitulo = [aDecoder decodeObjectForKey:@"SUBTITULO_KEY"];
        _descripcion = [aDecoder decodeObjectForKey:@"DESCRIPCION_KEY"];
        _precio = [aDecoder decodeFloatForKey:@"PRECIO_KEY"];
        _imagen = [aDecoder decodeObjectForKey:@"IMAGEN_KEY"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_titulo forKey:@"TITULO_KEY"];
    [aCoder encodeObject:_subTitulo forKey:@"SUBTITULO_KEY"];
    [aCoder encodeObject:_descripcion forKey:@"DESCRIPCION_KEY"];
    [aCoder encodeFloat:_precio forKey:@"PRECIO_KEY"];
    [aCoder encodeObject:_imagen forKey:@"IMAGEN_KEY"];
}

@end
