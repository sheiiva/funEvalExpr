module Main where

import System.Environment ( getArgs )
import System.Exit ( exitWith, ExitCode( ExitFailure) )

import Run (run)
import ArgsManagement (checkArgs)

main :: IO ()
main = do
    args <- getArgs
    case checkArgs args of
        84 -> exitWith (ExitFailure 84)
        _ -> run args