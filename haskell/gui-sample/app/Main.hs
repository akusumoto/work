{-# LANGUAGE OverloadedLabels  #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Lib
import Data.GI.Base
import qualified GI.Gtk as Gtk

main :: IO ()
main = do
    Gtk.init Nothing
    win <- new Gtk.Window [ #title := "Sample GUI" ]
    on win #destroy Gtk.mainQuit

    button <- new Gtk.Button [ #label := "OK" ]
    on button #clicked (set button [ #sensitive := False, #label := "Clicked" ])
    #add win button

    #showAll win
    Gtk.main
