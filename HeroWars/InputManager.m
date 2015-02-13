//
//  InputManager.m
//  HeroWars
//
//  Created by Max Shashoua on 2/5/15.
//  Copyright (c) 2015 Max Shashoua. All rights reserved.
//

#import "InputManager.h"


@implementation InputManager

-(id)initWithBoard:(Gameboard *)board {
    self = [super init];
    if (self){
        [self setValue:@"battle" forKey:@"stage"];
        self.board = board;
        self.pather = [[Pather alloc]init];
    }
    return self;
}

-(void)receiveInputWithNodes:(NSArray *)touchedNodes andString: (NSString *)touchType {
    //select keyNode from node hierarchy
    SKNode *keyNode = [self findKeyNodeFromTouchedNodes:touchedNodes];
    // if battle stage
    if ([self.stage isEqualToString:@"battle"]) {
        // if hold
        if ([touchType isEqualToString: @"hold"]) {
            NSLog(@"Tile held");
        // if tap
        }else if ([touchType isEqualToString: @"tap"]) {
            // if unit
            if ([keyNode isKindOfClass:[Unit class]]) {
                NSLog(@"Unit tapped");
                self.selectedUnit = (Unit *)keyNode;
                [self setValue:@"unitMove" forKey:@"stage"];
            }
            //if tile
            else if ([keyNode isKindOfClass:[Tile class]]) {
                [self setValue:@"generalMenu" forKey:@"stage"];
            } else {
                NSLog(@"Error: no task for keyNode");
            }
        }
    }
    // if generalMenu stage
    else if ([self.stage isEqualToString:@"generalMenu"]) {
        if ([keyNode isKindOfClass:[Button class]] || [keyNode isKindOfClass:[GeneralMenu class]]){
            NSLog(@"menu stuff");
        } else {
            [self setValue:@"battle" forKey:@"stage"];
        }
    }
    // if unitMove stage
    else if ([self.stage isEqualToString:@"unitMove"]) {
        // if highlight
        if ([keyNode isKindOfClass:[Highlight class]]) {
            Tile *highlightedTile = (Tile *)[keyNode parent];
            [self.board moveUnit:self.selectedUnit toTile:highlightedTile];
            [self setValue:@"unitAction" forKey:@"stage"];
            [self setValue:@"battle" forKey:@"stage"];
            NSLog(@"unit moved to point (%d,%d)", self.selectedUnit.x, self.selectedUnit.y);
        } else {
            [self setValue:@"battle" forKey:@"stage"];
        }
    }
    // if unitAction stage
    else if ([self.stage isEqualToString:@"unitAction"]) {
//        if ([keyNode isKindOfClass:[Highlight class]]) {
//            [self setValue:@"unitAction" forKey:@"stage"];
//            
//        } else {
        [self setValue:@"battle" forKey:@"stage"];
//        }
    }
}

-(NSArray *)findTileCoordsToHighlight {
    NSArray *tileCoords = [self.pather tileCoordsForUnit:self.selectedUnit andBoard:self.board];
    return tileCoords;
}

-(SKNode *)findKeyNodeFromTouchedNodes:(NSArray *)touchedNodes {
    //select keyNode from node hierarchy
    NSArray *nodeHierarchy = @[[Button class],[Menu class],[Highlight class],[Unit class],/*[Building class],*/[Tile class]];
    SKNode *keyNode = [[SKNode alloc]init];
    for (Class classType in nodeHierarchy) {
        for (SKNode *node in touchedNodes) {
            if ([node isKindOfClass:classType]) {
                keyNode = node;
                return keyNode;
            }
        }
    }
    return nil;
}

-(BOOL)canDrag {
    return YES;
}

@end
