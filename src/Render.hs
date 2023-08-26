module Render where

import Graphics.Gloss
import Data.Array

import Data.Maybe

import Game

--Definição de cores
boardGridColor = makeColorI 0 0 0 255 --cor da grade do tabuleiro (preto)
movingPlayer = green --cor da peça selecionada (verde)
redPlayer = makeColorI 153 0 0 255 --cor das peças vermelhas
bluePlayer = makeColorI 0 0 204 255 --cor das peças azuis
winnerColor = green --cor das peças e tabuleiro vencedores (verde)
tieColor = greyN 0.5 --cor do empate
validCollor = makeColorI 255 255 255 255 --branco
invalidCollor = makeColorI 0 0 0 255 --preto

--mapeia status e devolve um board apropriado
gameAsPic :: Game -> Picture
gameAsPic game = translate (fromIntegral screenWidth * (-0.5)) (fromIntegral screenHeight * (-0.5)) frame
   where frame = case gameStatus game of
                    Move -> boardAsMovingPic game
                    GameOver winner -> boardAsGameOverPic (gameBoard game) winner
                    _ -> boardAsOnGoingPic (gameBoard game)

--board com jogo rodando
boardAsOnGoingPic board =
   pictures [ color invalidCollor $ invalidCell board
            , color validCollor $ validCell board
            , color bluePlayer $ bluePieces board
            , color redPlayer $ redPieces board
            , color boardGridColor $ boardGrid
            ]

--board com jogador fazendo movimento
boardAsMovingPic game
   | typePlayer game == Red = pictures [ color invalidCollor $ invalidCell board
            , color validCollor $ validCell board
            , color bluePlayer $ bluePieces board
            , color redPlayer $ redPieces board
            , color movingPlayer $ selectRedPiece board cell
            , color boardGridColor boardGrid
            ]
   | typePlayer game == Blue = pictures [ color invalidCollor $ invalidCell board
            , color validCollor $ validCell board
            , color bluePlayer $ bluePieces board
            , color redPlayer $ redPieces board
            , color movingPlayer $ selectBluePiece board cell
            , color boardGridColor boardGrid
            ]
   | otherwise = pictures [ color invalidCollor $ invalidCell board
            , color validCollor $ validCell board
            , color bluePlayer $ bluePieces board
            , color redPlayer $ redPieces board
            , color boardGridColor boardGrid
            ]
   where board = gameBoard game
         cell = lastClick game

--layout do tabuleiro caso haja vencedor
boardAsGameOverPic board winner
   | isNothing winner = pictures [ color tieColor $ bluePieces board
            , color tieColor $ redPieces board
            , color tieColor boardGrid
            ]
   | otherwise = pictures [ color winnerColor $ bluePieces board
            , color winnerColor $ redPieces board
            , color winnerColor boardGrid
            ]

snapPictureToCell picture (row, column) = translate x y picture
   where x = fromIntegral column * cellWidth + cellWidth * 0.5
         y = fromIntegral row * cellHeight + cellHeight * 0.5

--mapeia as peças do tabuleiro
boardPieces :: Board -> Celula -> Picture -> Picture
boardPieces board cell cellPicture =
   pictures
   $ map (snapPictureToCell cellPicture .fst)
   $ filter (\(_, e) -> e == cell)
   $ assocs board

selectPiece :: Board -> (Int,Int) -> Picture -> Picture
selectPiece board (x,y) cell =
   pictures
   $ map (snapPictureToCell cell .fst)
   $ filter (\((a,b), _) -> (a,b) == (x,y))
   $ assocs board
invalid (x,y) = not ((mod y 2 == 1 && mod x 2 == 1) || (mod y 2 == 0 && mod x 2 == 0))
valid (x,y) = (mod y 2 == 1 && mod x 2 == 1) || (mod y 2 == 0 && mod x 2 == 0)

--verificação de celula inválida
invalidCell :: Board -> Picture
invalidCell board =
   pictures
   $ map (snapPictureToCell (rectangleSolid cellWidth cellHeight) .fst)
   $ filter (\((a,b), _) -> invalid (a,b))
   $ assocs board

--verificação de celula válida
validCell :: Board -> Picture
validCell board = 
   pictures
   $ map (snapPictureToCell (rectangleSolid cellWidth cellHeight) .fst)
   $ filter (\((a,b), _) -> valid (a,b))
   $ assocs board

selectBluePiece :: Board -> (Int, Int) -> Picture
selectBluePiece board point = selectPiece board point cell

selectRedPiece :: Board -> (Int, Int) -> Picture
selectRedPiece board point = selectPiece board point cell

circle1 = circleSolid radius 
   where radius = min cellWidth cellHeight * 0.40

circle2 = color black $ circle radius 
   where radius = min cellWidth cellHeight * 0.10

circle3 = color black $ circle radius 
   where radius = min cellWidth cellHeight * 0.15

circle4 = color black $ circle radius 
   where radius = min cellWidth cellHeight * 0.25

circle5 = color black $ circle radius 
   where radius = min cellWidth cellHeight * 0.30

--constroi a peça do jogo a partir dos circulos
cell :: Picture
cell = pictures [circle1, circle2, circle3, circle4, circle5]

--peças vermelhas
redPieces :: Board -> Picture
redPieces board = boardPieces board (Full Red) cell

--peças azuis
bluePieces :: Board -> Picture
bluePieces board = boardPieces board (Full Blue) cell

--constroi grade do tabuleiro
boardGrid :: Picture
boardGrid =
   pictures
   $ concatMap (\i -> [ line [ (i * cellWidth, 0.0),
                               (i * cellWidth, fromIntegral screenHeight)
                             ]
                      , line [ (0.0, i * cellHeight)
                             , (fromIntegral screenWidth, i * cellHeight)
                             ]
                        ])
   [0.0 .. fromIntegral n]
