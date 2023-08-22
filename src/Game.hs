module Game where

import Data.Array

initGame = Game { gameBoard = inicioJogoTab
                   , tipoJogador = Vermelho
                   , statusJogo = Running
                   , ultimoClick = (-1,-1)
                   , changeRock = True
                  }