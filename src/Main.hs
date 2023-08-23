module Main (main) where
import Graphics.Gloss
import Graphics.Gloss.Data.Color
import Game
import Controller
import Render

main :: IO ()

size = (640, 640)
position = (100, 100)
backgroundColor = black

main = display (InWindow "Checkers" size position) backgroundColor (Circle 80)
