import System.Directory

showFiles [] = ""
showFiles (f:fs) = f ++ "\n" ++ showFiles fs

main = do
    list <- getDirectoryContents "."
    putStrLn $ showFiles list
