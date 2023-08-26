module Main (main) where

import Graphics.Gloss

import Game
import Controller
import Render

backgroundColor :: Color
backgroundColor = makeColorI 36 152 82 255 --background verde

main :: IO ()
main = play FullScreen backgroundColor 30  initGame gameAsPic updateGame (\_->id)
---- Play:           Função pra display interativo
-- FullScreen:       Abre o jogo em tela cheia
-- backgroundColor:  cor de fundo 
-- 30:               fps
-- initGame:         modelo inicial da tela
-- gameAsPic:        função que dada uma interação/Evento e meu modelo atual vc me dá um novo modelo
-- updateGame:       Atualiza o game dado a interação do usuário
-- (\_->id):         Não utilizamos esse parametro pois não atualizamos o game com o tempo e sim com interações
--                   então passamos só uma função identidade