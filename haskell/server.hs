{-# LANGUAGE OverloadedStrings #-}

import Network.HTTP.Types (status200)
import Network.Wai (responseLBS)
import Network.Wai.Handler.Warp (run)
import Control.Concurrent
main :: IO ()
main = runInUnboundThread $ run 8080 app
  where
    app _ respond = do
        respond $ responseLBS status200 [("Content-Type", "text/plain")]
                  "Hello, world!" 
