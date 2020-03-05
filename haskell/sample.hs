c_black   = "\x1b[30m"
c_red     = "\x1b[31m"
c_green   = "\x1b[32m"
c_yellow  = "\x1b[33m"
c_blue    = "\x1b[34m"
c_magenta = "\x1b[35m"
c_cyan    = "\x1b[36m"
c_white   = "\x1b[37m"
c_end     = "\x1b[0m"

main :: IO()
main = do
    putStrLn $ c_black   ++ "Black"   ++ c_end
    putStrLn $ c_red     ++ "Red"     ++ c_end
    putStrLn $ c_green   ++ "Green"   ++ c_end
    putStrLn $ c_yellow  ++ "Yellow"  ++ c_end
    putStrLn $ c_blue    ++ "Blue"    ++ c_end
    putStrLn $ c_magenta ++ "Magenta" ++ c_end
    putStrLn $ c_cyan    ++ "Cyan"    ++ c_end
    putStrLn $ c_white   ++ "White"   ++ c_end
