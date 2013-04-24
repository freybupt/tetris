//
//  PieceView.m
//  Tetris360
//
//  Created by Liang Shi on 4/22/13.
//  Copyright (c) 2013 Gree. All rights reserved.
//

#import "PieceView.h"
#import "GameController.h"

@implementation PieceView


- (id)initWithPieceType:(PieceType)type{
    self.pieceType = type;
    CGRect frame = CGRectMake(0, 0, kGridSize, kGridSize);
    switch (type) {
        case PieceTypeI:
            frame = CGRectMake(0, 0, kGridSize * 4, kGridSize);
            break;
        case PieceTypeO:
            frame = CGRectMake(0, 0, kGridSize * 2, kGridSize * 2);
            break;
        case PieceTypeJ:
        case PieceTypeL:
        case PieceTypeS:
        case PieceTypeT:
        case PieceTypeZ:
            frame = CGRectMake(0, 0, kGridSize * 3, kGridSize * 2);
            break;
        default:
            break;
    }
    
    return [self initWithFrame:frame];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)moveToColumn:(NSInteger)column
{
    NSLog(@"Moving to column: %ld", (long)column);
    if (column == self.currentColumn) {
        return;
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x - column * kGridSize, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
    self.currentColumn = column;
}


- (UIColor*)getColorOfType: (PieceType)type{
    switch (type) {
        case PieceTypeI:
            return [UIColor redColor];
            break;
        case PieceTypeO:
            return [UIColor orangeColor];
            break;
        case PieceTypeJ:
            return [UIColor yellowColor];
            break;
        case PieceTypeL:
            return [UIColor greenColor];
            break;
        case PieceTypeS:
            return [UIColor blueColor];
            break;
        case PieceTypeT:
            return [UIColor purpleColor];
            break;
        case PieceTypeZ:
            return [UIColor cyanColor];
            break;
        default:
            return nil;
            break;
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //draw each piece based on piece type
    CGRect rectangle;
    CGContextRef context = UIGraphicsGetCurrentContext();
//    [[UIColor blackColor] setStroke];
    switch (self.pieceType) {
        case PieceTypeI:
            [[UIColor redColor] setFill];
            UIRectFill( rect );
            rectangle = CGRectMake(0, kGridSize, kGridSize * 4, kGridSize);
            CGContextClearRect(context, rectangle);
//            CGContextStrokeRect(context, rectangle);
            break;
        case PieceTypeO:
            [[UIColor orangeColor] setFill];
            UIRectFill( rect );
            break;
        case PieceTypeJ:
            [[UIColor yellowColor] setFill];
            UIRectFill( rect );
            rectangle = CGRectMake(kGridSize, 0, kGridSize * 2, kGridSize);
            CGContextClearRect(context, rectangle);
            break;
        case PieceTypeL:
            [[UIColor greenColor] setFill];
            UIRectFill( rect );
            rectangle = CGRectMake(0, 0, kGridSize * 2, kGridSize);
            CGContextClearRect(context, rectangle);
            break;
        case PieceTypeS:
            [[UIColor blueColor] setFill];
            UIRectFill( rect );
            rectangle = CGRectMake(0, 0, kGridSize, kGridSize);
            CGContextClearRect(context, rectangle);
            rectangle = CGRectMake(kGridSize * 2, kGridSize, kGridSize, kGridSize);
            CGContextClearRect(context, rectangle);
            break;
        case PieceTypeT:
            [[UIColor purpleColor] setFill];
            UIRectFill( rect );
            rectangle = CGRectMake(0, kGridSize, kGridSize, kGridSize);
            CGContextClearRect(context, rectangle);
            rectangle = CGRectMake(kGridSize * 2, 0, kGridSize, kGridSize);
            CGContextClearRect(context, rectangle);
            break;
        case PieceTypeZ:
            [[UIColor cyanColor] setFill];
            UIRectFill( rect );
            rectangle = CGRectMake(0, 0, kGridSize, kGridSize);
            CGContextClearRect(context, rectangle);
            rectangle = CGRectMake(kGridSize * 2, 0, kGridSize, kGridSize);
            CGContextClearRect(context, rectangle);
            break;
        default:
            break;
    }
    
}



@end
