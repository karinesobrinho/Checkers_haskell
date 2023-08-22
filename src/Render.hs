module Render where

import Graphics.Gloss
import Data.Array

import Data.Maybe
import Game

circle1 = circleSolid radius 
   where radius = min larguraCelula alturaCelula * 0.40

circle2 = color black $ circle radius 
   where radius = min larguraCelula alturaCelula * 0.10

circle3 = color black $ circle radius 
   where radius = min larguraCelula alturaCelula * 0.15

circle4 = color black $ circle radius 
   where radius = min larguraCelula alturaCelula * 0.25

circle5 = color black $ circle radius 
   where radius = min larguraCelula alturaCelula * 0.30

piece :: Picture
piece = pictures [circle1, circle2, circle3, circle4, circle5]
