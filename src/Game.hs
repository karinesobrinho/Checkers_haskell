module Game where

import Data.Array

screenWidth, screenHeight :: Int
cellHeight, cellWidth :: Float

screenWidth = 640
screenHeight = 640

cellHeight = fromIntegral screenHeight / fromIntegral 8
cellWidth = fromIntegral screenWidth / fromIntegral 8