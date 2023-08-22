module Main (main) where
import Graphics.Gloss
import Graphics.Gloss.Data.Color

main :: IO ()
main = display (InWindow "Checkers" (200, 200) (10, 10)) red (Circle 80)
