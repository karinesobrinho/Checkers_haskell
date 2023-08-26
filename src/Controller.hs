module Controller where
import Data.Array
import Game
import Graphics.Gloss.Interface.Pure.Game

validCoord = inRange ((0,0), (n-1, n-1))

nextPlayer :: Game -> (Int, Int) -> (Int, Int) -> (Int, Int) -> Game
nextPlayer game (x,y) (a,b) lastCell

   | validCoord (x+1, y+1) 
      && board ! (x+1, y+1) == (Full $ opponent player) 
      && validCoord (x+2, y+2) 
      && board ! (x+2, y+2) == Empty
         = game {gameBoard = board // [(lastCell, Empty), ((a, b), Empty), ((x,y), Full $ player)]
                , typePlayer = player
                , gameStatus = Move
                , lastClick = (x,y)
                , changeRock = False}

   | validCoord (x-1, y+1) 
      && board ! (x-1, y+1) == (Full $ opponent player) 
      && validCoord (x-2,y+2) 
      && board ! (x-2, y+2) == Empty
         = game {gameBoard = board // [(lastCell, Empty), ((a, b), Empty), ((x,y), Full $ player)]
                , typePlayer = player
                , gameStatus = Move
                , lastClick = (x,y)
                , changeRock = False}

   | validCoord (x-1, y-1) 
      && board ! (x-1, y-1) == (Full $ opponent player) 
      && validCoord (x-2, y-2) 
      && board ! (x-2, y-2) == Empty
         = game {gameBoard = board // [(lastCell, Empty), ((a, b), Empty), ((x,y), Full $ player)]
                , typePlayer = player
                , gameStatus = Move
                , lastClick = (x,y)
                , changeRock = False}

   | validCoord (x+1, y-1) 
      && board ! (x+1,y-1) == (Full $ opponent player) 
      && validCoord (x+2,y-2) 
      && board ! (x+2, y-2) == Empty
         = game {gameBoard = board // [(lastCell, Empty), ((a, b), Empty), ((x,y), Full $ player)]
                , typePlayer = player
                , gameStatus = Move
                , lastClick = (x,y)
                , changeRock = False}

   | otherwise = game {gameBoard = board // [(lastCell, Empty), ((a,b), Empty), ((x, y), Full $ player)],  typePlayer = opponent player, gameStatus = OnGoing, changeRock = True}

   where board = gameBoard game
         player = typePlayer game

possibleMovRed :: Game -> (Int, Int) -> Game
possibleMovRed game (x,y)
   | mov1 || mov2 || eat1 || eat2 || eat3 || eat4 = game {gameBoard = board, gameStatus = Move, lastClick = (x,y)}
   | otherwise = game   
   where mov1=validCoord (x+1, y-1) && board ! (x+1, y-1) == Empty 
         mov2=validCoord (x+1, y+1) && board ! (x+1, y+1) == Empty 
         eat1= validCoord (x+1, y+1) && board ! (x+1, y+1) == (Full $ opponent player) 
            && validCoord (x+2,y+2) && board ! (x+2,y+2) == Empty 
         eat2=validCoord (x-1, y+1) && board ! (x-1, y+1) == (Full $ opponent player) 
            && validCoord (x-2,y+2) && board ! (x-2,y+2) == Empty 
         eat3=validCoord (x+1, y-1) && board ! (x+1, y-1) == (Full $ opponent player) 
            && validCoord (x+2,y-2) && board ! (x+2,y-2) == Empty 
         eat4=validCoord (x-1, y-1) && board ! (x-1, y-1) == (Full $ opponent player) 
            && validCoord (x-2,y-2) && board ! (x-2,y-2) == Empty 
         board = gameBoard game
         player = typePlayer game
         lastCell = lastClick game

possibleMovBlue :: Game -> (Int, Int) -> Game
possibleMovBlue game (x,y)
   | mov1 || mov2 || eat1 || eat2 || eat3 || eat4 = game {gameBoard = board, gameStatus = Move, lastClick = (x,y)}
   | otherwise = game
   where 
         mov1=validCoord (x-1, y-1) && board ! (x-1, y-1) == Empty
         mov2=validCoord (x-1, y+1) && board ! (x-1, y+1) == Empty
         eat1=validCoord (x-1, y+1) && board ! (x-1, y+1) == (Full $ opponent player) 
            && validCoord (x-2,y+2) && board ! (x-2,y+2) == Empty
         eat2=validCoord (x+1, y+1) && board ! (x+1, y+1) == (Full $ opponent player) 
            && validCoord (x+2,y+2) && board ! (x+2,y+2) == Empty
         eat3=validCoord (x+1, y-1) && board ! (x+1, y-1) == (Full $ opponent player)
            && validCoord (x+2,y-2) && board ! (x+2,y-2) == Empty
         eat4=validCoord (x-1, y-1) && board ! (x-1, y-1) == (Full $ opponent player) 
            && validCoord (x-2,y-2) && board ! (x-2,y-2) == Empty            
         board = gameBoard game
         player = typePlayer game
         lastCell = lastClick game

opponent :: Player -> Player
opponent player
   | player == Blue = Red
   | otherwise = Blue

movePiece :: Game -> (Int, Int) -> Game
movePiece game cellCoord  
   | validCoord cellCoord && player == Red = movePieceRed game cellCoord
   | validCoord cellCoord && player == Blue = movePieceBlue game cellCoord
   | otherwise = game
   where player = typePlayer game

movePieceBlue :: Game -> (Int, Int) -> Game
movePieceBlue game (x,y)
   | mov1 || mov2 && board ! (x, y) == Empty 
        = game {gameBoard    = board // [((x, y), Full $ player), (lastCell, Empty)]--Atualizo Board
                ,typePlayer  = opponent $ player
                , gameStatus = newStatus
               }
   | eat1 = nextPlayer game (x,y) (x+1,y-1) lastCell
   | eat2 = nextPlayer game (x,y) (x-1,y-1) lastCell
   | eat3 = nextPlayer game (x,y) (x-1,y+1) lastCell
   | eat4 = nextPlayer game (x,y) (x+1,y+1) lastCell
   | not (changeRock game) = game
   | otherwise = game {gameStatus = newStatus}

   where mov1=(x+1, y+1) == lastCell
         mov2=(x+1,y-1)==lastCell
         eat1= validCoord (x+1, y-1) && board ! (x+1,y-1) == (Full $ opponent player) 
            && validCoord (x+2,y-2)  && (x+2,y-2) == lastCell 
            && board ! (x, y) == Empty
         eat2= validCoord (x-1,y-1) && board ! (x-1, y-1) == (Full $ opponent player) 
            && validCoord (x-2,y-2)  && (x-2,y-2) == lastCell 
            && board ! (x, y) == Empty
         eat3= validCoord (x-1,y+1) && board ! (x-1, y+1) == (Full $ opponent player) 
            && validCoord (x-2,y+2) && (x-2,y+2) == lastCell 
            && board ! (x, y) == Empty
         eat4= validCoord (x+1, y+1) && board ! (x+1, y+1) == (Full $ opponent player) 
            && validCoord (x+2,y+2) && (x+2,y+2) == lastCell 
            && board ! (x, y) == Empty

         board     = gameBoard game
         player    = typePlayer game
         lastCell  = lastClick game
         newStatus = statsAfterPlay game


movePieceRed :: Game -> (Int, Int) -> Game
movePieceRed game (x,y)
   | (mov1|| mov2) && board ! (x, y) == Empty 
      = game {gameBoard = board // [((x, y), Full $ player), (lastCell, Empty)] 
              ,typePlayer = opponent $ typePlayer game
              ,gameStatus = newStatus}
   | eat1 = nextPlayer game (x,y) (x-1,y-1) lastCell
   | eat2 = nextPlayer game (x,y) (x+1, y-1) lastCell
   | eat3 = nextPlayer game (x,y) (x-1,y+1) lastCell
   | eat4 = nextPlayer game (x,y) (x+1, y+1) lastCell
   | not (changeRock game) = game
   | otherwise = game {gameStatus = newStatus}

   where mov1=(x-1, y+1) == lastCell
         mov2=(x-1,y-1)==lastCell 
         eat1= validCoord (x-1, y-1) && board ! (x-1, y-1) == (Full $ opponent player) 
            && validCoord (x-2,y-2)  && (x-2,y-2) == lastCell 
            && board ! (x, y) == Empty 
         eat2= validCoord (x+1, y-1) && board ! (x+1, y-1) == (Full $ opponent player) 
            && validCoord (x+2,y-2)  && (x+2,y-2) == lastCell 
            && board ! (x, y) == Empty
         eat3= validCoord (x-1, y+1) && board ! (x-1, y+1) == (Full $ opponent player) 
            && validCoord (x-2,y+2)  && (x-2,y+2) == lastCell 
            && board ! (x, y) == Empty
         eat4= validCoord (x+1, y+1) && board ! (x+1, y+1) == (Full $ opponent player) 
            && validCoord (x+2,y+2)  && (x+2,y+2) == lastCell 
            && board ! (x, y) == Empty  
         board = gameBoard game
         player = typePlayer game
         lastCell = lastClick game
         newStatus = statsAfterPlay game

-- função principal que altera o estado do jogo dado um evento. Basicamente um switch case dado o estado do jogo
updateGame :: Event -> Game -> Game
updateGame (EventKey (MouseButton LeftButton) Up _ mousePos) game =
   case gameStatus game of
      GameOver _ -> initGame
      OnGoing -> playerTurn game cellCoord--posição da peça escolhida para mover
      Move -> movePiece game cellCoord--posição pós comer peça
   where cellCoord = mousePosToCell mousePos
updateGame _ game = game

mousePosToCell :: (Float, Float) -> (Int, Int)
mousePosToCell (x,y) = ( floor ((y + boardHeight) /cellHeight)
                        ,floor ((x + boardLength) /cellWidth)
                       )
   where boardHeight = (fromIntegral screenHeight * 0.5)
         boardLength = (fromIntegral screenWidth * 0.5)

{--
   tem como objetivo mapear coordenadas de um plano bidimensional para as coordenadas de células em uma    grade. Ela recebe um par de valores (x, y) que representam uma posição no plano. A função então calcula em qual célula da grade essa posição se encontra e retorna as coordenadas da célula como um par de inteiros 
   Como o centro da tela é o ponto (0,0) dividesse a altura e largura por dois para ter as coordenadas dos limites superior e inferior do tabuleiro. Dividindo esses valores pela alutra da célula, é possível traduzir a posição do mouse em termos de celulas
--}

evallPlayerTurn:: Game->(Int,Int)->(State,Bool,Celula,Player)
evallPlayerTurn game cellCoord=  (statsAfterPlay game
                                 ,validCoord cellCoord
                                 ,board ! cellCoord
                                 ,player)
   where board    = gameBoard game
         player   = typePlayer game

statsAfterPlay :: Game -> State
-- Função que conta numero de peças vermelhas e Blues e define um estado novo para o jogo em consequencia 
statsAfterPlay game
   | bluePieces == 0 = GameOver (Just Red)
   | redPieces   == 0 = GameOver (Just Blue)
   | allPieces   == 2 = GameOver Nothing
   | otherwise        = OnGoing
   where
      allPieces = bluePieces + redPieces
      bluePieces = countPieces (Full Blue) (elems $ gameBoard game)
      redPieces = countPieces (Full Red) (elems $ gameBoard game)
      countPieces player xs = length $ filter (== player) xs

playerTurn :: Game -> (Int, Int) -> Game
playerTurn game cellCoord = case evallPlayerTurn game cellCoord of
   (OnGoing,True, Full player, Red)  ->  possibleMovRed game cellCoord
   --caso o jogador selecione uma peça Vermelha
   (OnGoing,True, Full player, Blue)    -> possibleMovBlue game cellCoord
   --caso o jogador selecione uma peça Blue
   (redWon,_,_,_)      ->   game {gameStatus = redWon}
   --Caso o status do jogo pós movimento seja vitória do Red, mude o estado do jogo para tal
   (blueWon,_,_,_)    ->   game {gameStatus = blueWon}
   --Caso o status do jogo pós movimento seja vitória do Blue, mude o estado do jogo para tal
   (draw,_,_,_)        ->   game {gameStatus = draw}
   --Caso o status do jogo pós movimento seja empate, mude o estado do jogo para tal
   (OnGoing,_,_,_)   ->game
   --Otherwise 
   where redWon   = GameOver (Just Red)
         blueWon = GameOver (Just Blue) 
         draw     = GameOver Nothing
         player   = typePlayer game
