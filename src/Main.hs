module Main (main) where

import Graphics.Gloss

import Game
import Controller
import Render

backgroundColor :: Color
backgroundColor = makeColorI 36 152 82 255 --background verde

main :: IO ()
main = play FullScreen backgroundColor 30  initGame gameAsPic updateGame (\_->id)
--abre tela inteira, para sair pressionar ESC
