//
//  Ballista.m
//  HeroWars
//
//  Created by Connor Levesque on 5/26/15.
//  Copyright (c) 2015 Max Shashoua. All rights reserved.
//

#import "Ballista.h"

@implementation Ballista

-(id)initOnTile:(Tile *)tile withColors:(NSArray *)playerColors withOwner:(NSInteger)owner {
    self = [super init];
    if (self) {
        self.x = tile.x;
        self.y = tile.y;
        self.owner = owner;
        self.teamColor = playerColors[self.owner - 1];
        // set type specific properties
        self.type = @"ballista";
        NSString *imageName = [NSString stringWithFormat:@"HeroWars_%@_%@", self.type, self.teamColor];
        self.texture = [SKTexture textureWithImageNamed:imageName];
        self.size = self.texture.size;
        self.color = [UIColor whiteColor];
        // Set Gameplay Properties
        self.group = @"artillery";
        self.move = 4;
        self.range = @[@2,@3];
        self.canMoveAndAttack = NO;
        self.power = 50;
        self.accuracy = 90;
        self.weapon = 10;
        self.armor = 50;
    }
    return self;
}

@end
