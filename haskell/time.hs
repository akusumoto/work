import Data.Time

main = do
    t <- formatTime defaultTimeLocale "%Y/%m/%d %H:%M:%S %Z" <$> getZonedTime
    putStrLn t
