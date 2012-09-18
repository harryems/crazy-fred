//
//  global.m
//  crazy fred
//
//  Created by Carlos Espinosa de los Monteros on 9/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "global.h"


int gCurrentSong;
float gScore;
NSMutableArray  *secuencia;
NSString *gCTitle;

 NSString* gSongs[] =
{   @"Guns.mp3",
    @"Hey girl.mp3",
    @"red hot chilli pepper.mp3",
    @"ac:dc.mp3"
};
NSString* gTitles[] =
{   @"Guns & Rouses",
    @"Infected mushrums",
    @"red hot chilli pepper",
    @"ac:dc"
};

NSString  *gDisplaySongs[] =
{   @"Guns & Rouses-Cancion",
    @"Interprete-Infected mushrums",
    @"red hot chilli pepper-Cancion",
    @"ac:dc-Cancion"
};

float gTimingLevel[] =
{
  1.0,
  0.5,
  0.30,
  0.15
};



int gTopLevel[] ={
    7,
    10,
    15,
    20
};

int secuencia1[]={1,2,3,4,5,6,7};
int secuencia2[]={1,2,3,4,5,6,7,8,9,1};
int secuencia3[]={1,2,3,4,5,6,7,8,9,1,2,3,4,5,6};
int secuencia4[]={1,2,3,4,5,6,7,8,9,1,2,3,4,5,6,7,8,9,1,2};


int gResultado;






