{-# LANGUAGE ScopedTypeVariables #-}
import System.IO
import Control.Exception

loop :: Int -> Handle -> IO()
loop i h = do
    eof <- hIsEOF h
    if not eof
        then do
            s <- hGetLine h
            putStrLn $ show i ++ " : " ++ s
            loop (i+1) h
        else 
            return ()

main :: IO()
main = do
    -- h <- openFile "sample.txt" ReadMode
        h <- openFile "sample.txt" ReadMode
        loop 0 h
        hClose h
    `catch` (
        \(e :: SomeException) -> putStrLn $ "read failure: " ++ displayException e
    )
