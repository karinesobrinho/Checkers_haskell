module Main (main) where
import Graphics.Gloss
import Graphics.Gloss.Data.Color

main :: IO ()

size = (640, 640)
position = (100, 100)
backgroundColor = blue

main = display (InWindow "Checkers" size position) backgroundColor (Circle 80)
