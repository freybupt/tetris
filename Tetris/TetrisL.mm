//
//  TetrisL.m
//  Tetris
//
//  Created by Yuan Yeh on 2013-04-24.
//  Copyright (c) 2013 teamtetris. All rights reserved.
//

#import "TetrisL.h"

@implementation TetrisL

- (id)init {
    self = [super init];
    
    // create L blocks
    GLKVector4 color = GLKVector4Make(0.25, 1, 0.25, 1);
    TetrisDrawable *block;
    // block 1
    block = [TetrisDrawable new];
    [block setPosition:0 :0 :0];
    [block setColor:color];
    [self add:block];
    // block 2
    block = [TetrisDrawable new];
    [block setPosition:0 :1 :0];
    [block setColor:color];
    [self add:block];
    // block 3
    block = [TetrisDrawable new];
    [block setPosition:0 :2 :0];
    [block setColor:color];
    [self add:block];
    // block 4
    block = [TetrisDrawable new];
    [block setPosition:1 :0 :0];
    [block setColor:color];
    [self add:block];
    
    return self;
}

- (void)onDraw:(GLKMatrix4)viewMatrix {
    [super onDraw:viewMatrix];
}

@end
