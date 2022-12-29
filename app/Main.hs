{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Text.URI as URI

main :: IO ()
main = do
  scheme <- URI.mkScheme "https"
  host <- URI.mkHost "markkarpov.com"
  let uri = URI.URI (Just scheme) (Right (URI.Authority Nothing host Nothing)) Nothing [] Nothing
  print uri
