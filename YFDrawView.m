//
//  YFDrawView.m
//  CollectiveView
//
//  Created by ky on 16/5/24.
//  Copyright © 2016年 user. All rights reserved.
//

#import "YFDrawView.h"

static const int xOffset = 25;

static const int yOffset = 5;

static const int width = 16;

static const int height = 16;

@interface YFDrawView()

@property (nonatomic, retain) NSMutableArray *arrayLables;

@end

@implementation YFDrawView

- (void)clear {
    
    for (UILabel *label in _arrayLables) {
        
        [label removeFromSuperview];
    }
    
    [_arrayLables removeAllObjects];
}

- (void)setNumber:(int)number {
    
    if (_number == number) {
        
        return;
    }
    
    _number = number;
    
    [self refresh];
}

- (void)drawRectangle:(CGPoint)orig {
    
    for (int i = 1; i <= _number; ++i) {
        
        int x = (i - 1) * (xOffset + width);
        
        int y = (i - 1) * (yOffset + height);
        
        [self drawRectNumber:i orig:CGPointMake(orig.x + x, orig.y + y)];
    }
}

- (void)refresh {
    
    [self clear];
    
    [self drawRectangle:CGPointMake(10, 100)];
    
    [self drawRhombus:CGPointMake(10, 100 + 200)];
}

- (CGRect)retriveRect:(int)x y:(int)y orig:(CGPoint)orig {
    
    CGRect rect;
    
    rect.size.width = width;
    
    rect.size.height = height;
    
    rect.origin.x = orig.x + (xOffset + width) * x;
    
    rect.origin.y = orig.y + (yOffset + height) * y;
    
    return rect;
}

- (void)drawNumber:(int)x y:(int)y number:(int)number orig:(CGPoint)orig {
    
    CGRect rect = [self retriveRect:x y:y orig:orig];
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    [label setText:[NSString stringWithFormat:@"%d", number]];
    
    [self addSubview:label];
    
    [_arrayLables addObject:label];
}

- (void)drawRectNumber:(int)number orig:(CGPoint)orig {
    
    int count = _number * 2 - 2 * number + 1;
    
    for (int i = 0; i < count; ++i) {
        
        for (int j = 0; j < count; ++j) {
            
            if (i == 0 || j == 0 || i == count - 1 || j == count - 1) {
                
                [self drawNumber:i y:j number:number orig:orig];
            }
        }
    }
}

- (void)drawRect:(CGRect)rect {
    
    for (int i = 1; i <= _number; ++i) {
        
        int x = (i - 1) * (xOffset + width);
        
        int y = (i - 1) * (yOffset + height);
        
        [self drawRectPath:i orig:CGPointMake(10 + x, 100 + y)];
    }
    
    for (int i = 1; i <= _number; ++i) {
        
        int x = (i - 1) * (xOffset + width);
        
        int y = (i - 1) * (yOffset + height);
        
        [self drawRhombusPath:i orig:CGPointMake(10 + x, 300 + y)];
    }
}

- (void)drawRectPath:(int)number orig:(CGPoint)orig {
    
    int count = _number * 2 - 2 * number + 1;
    
    CGPoint A = orig;
    
    CGPoint B = CGPointMake(orig.x + (count - 1) * (xOffset + width) + width, orig.y);
    
    CGPoint C = CGPointMake(B.x, orig.y + (count- 1) * (yOffset + height) + height);
    
    CGPoint D = CGPointMake(A.x, C.y);
    
    [self drawPath:A B:B C:C D:D];
}

- (void)drawPath:(CGPoint)A B:(CGPoint)B C:(CGPoint)C D:(CGPoint)D {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:A];
    
    [path addLineToPoint:B];
    
    [path addLineToPoint:C];
    
    [path addLineToPoint:D];
    
    [path closePath];
    
    path.lineWidth = 1;
    
    UIColor *strokeColor = [UIColor redColor];
    
    [strokeColor set];
    
    [path stroke];
}

- (void)drawRhombus:(CGPoint)orig {
    
    for (int i = 1; i <= _number; ++i) {
        
        int x = (i - 1) * (xOffset + width);
        
        int y = (i - 1) * (yOffset + height);
        
        [self drawRhombus:i orig:CGPointMake(orig.x + x, orig.y + y)];
    }
}

- (void)drawRhombus:(int)number orig:(CGPoint)orig {
    
    int count = _number * 2 - 2 * number + 1;
    
    for (int i = 0; i < count; ++i) {
        
        for (int j = 0; j < count; ++j) {
            
            int value = count / 2;
            
            if (i + j == value ||
                i - j == value ||
                j - i == value ||
                i + j == value + count - 1) {
                
                [self drawNumber:i y:j number:number orig:orig];
            }
        }
    }
}

- (void)drawRhombusPath:(int)number orig:(CGPoint)orig {
    
    int count = _number * 2 - 2 * number + 1;
    
    int halfCount = count / 2;
    
    float centerX = orig.x + halfCount * (xOffset + width) + 0.5 * width;
    
    float centerY = orig.y + halfCount * (yOffset + height) + 0.5 * height;
    
    float g = (xOffset + width + 0.5 * width) * 1.0/(yOffset + height + 0.5 * height);
    
    float y = halfCount * (yOffset + height) + 0.5 * height;
    
    y *= 1.1;
    
    float x = g * y;
    
    CGPoint A = CGPointMake(centerX, centerY - y);
    
    CGPoint B = CGPointMake(centerX + x, centerY);
    
    CGPoint C = CGPointMake(centerX, centerY + y);
    
    CGPoint D = CGPointMake(centerX - x, centerY);
    
    [self drawPath:A B:B C:C D:D];
}

@end
