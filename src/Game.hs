module Game where

import Data.Array

data Player = Red | Blue deriving (Eq, Show) --jogador vermelho ou azul
data Celula = Empty | Full Player deriving (Eq, Show) --celula possui peça ou não
data State = Move | OnGoing | GameOver (Maybe Player) deriving (Eq, Show) --estado do jogo definido 

type Board = Array (Int, Int) Celula --o jogo é definido por
data Game = Game { gameBoard :: Board --como está o tabuleiro
                 , lastClick :: (Int, Int) --o último click do jogador
                 , changeRock :: Bool --se podemos ou não mover peças
                 , typePlayer :: Player --o jogador da rodada
                 , gameStatus :: State --o status do jogo
                 } deriving (Eq, Show)

initGame :: Game
initGame = Game { gameBoard = initialBoard 
                  , lastClick = (-1,-1) --começa sem último click
                  , changeRock = True --começa com movimento habilitado
                  , typePlayer = Red --começa com movimento do jogador vermelho
                  , gameStatus = OnGoing --começa com status OnGoing
                }

initialBoard :: Board
initialBoard = (array indexRange initialPieces)
   where 
    indexRange = ((0,0), (n-1, n-1))
    initialPieces = [((x, y), player (x, y)) | x<-[0..7], y<-[0..7]]

player :: (Int, Int) -> Celula
player (l,c)
   | (l==0 ||l==2) && (mod c 2 ==1) || (l==1) && (mod c 2 ==0) = Full Red
   | (l==5 ||l==7) && (mod c 2 ==0) || (l==6) && (mod c 2 ==1) = Full Blue
   | otherwise = Empty

screenWidth, screenHeight, n :: Int
cellHeight, cellWidth :: Float

n = 8 --numero de colunas/linhas

screenWidth = 640 --tamanho do tabuleiro (largura)
screenHeight = 640 --tamanho do tabuleiro (altura)

cellHeight = fromIntegral screenHeight / fromIntegral 8 --tamanho da celula (altura)
cellWidth = fromIntegral screenWidth / fromIntegral 8 --tamanho da celula (largura)
