{-# LANGUAGE OverloadedStrings #-}

import Data.Text (Text)
import qualified Data.Text as T
import Data.List (sortBy)
import Data.Maybe (fromMaybe)
import Data.Text.ICU (collator, collate, LocaleName(Locale))

type SortText = Maybe Text -> Text -> Text -> Ordering

sortText :: SortText
sortText = collate . collator . Locale . T.unpack . fromMaybe "en"

main = do
  putStrLn "Q: Why did the multi-threaded chicken cross the road?"
  putStrLn $ "A: "  ++ testSort "To get to the other side."

testSort :: String -> String
testSort =
    T.unpack . T.unwords . sortBy (sortText Nothing) . T.words . T.pack
