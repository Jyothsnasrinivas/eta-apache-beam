module Main where

main :: IO ()
main = java $ do
    options <- createBeam
    p <- createPipeline <.> options
    let readFile = fromBeam "gs://apache-beam-samples/shakespeare/*"
    p <.> applyPipeline readBeam <.> readFile TODO
