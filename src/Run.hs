module Run
    ( run
    ) where

import System.Exit
import Text.Printf
import Data.List

import Parser
import Utils

compute :: Double -> Double -> [Char] -> IO (Double)
compute a b op =
    case op of
        "+" -> return (a + b)
        "-" -> return (a - b)
        "*" -> return (a * b)
        "/" -> if (b == 0)
                    then exitWith (ExitFailure 84)
                else return (a / b)
        "^" -> return (a ** b)

shuntingYard :: [[Char]] -> [[Char]] -> [[Char]] -> IO ([[Char]])
shuntingYard [] output stack = return (output ++ stack)
shuntingYard ("(":input) output stack = shuntingYard input output (["("] ++ stack)
shuntingYard (")":input) output stack = let toRemove = (takeWhile ("("/=) stack)
                                        in if (toRemove == stack)
                                            then exitWith (ExitFailure 84)
                                            else shuntingYard input (output ++ toRemove) (drop ((length toRemove) + 1) stack)
shuntingYard (current:input) output stack
    | (isFloat current == True) = shuntingYard input (output ++ [current]) stack
    | (isInList current listValidOp == True) = let toRemove = takeWhile isStronger stack
                                                in shuntingYard input (output ++ toRemove) ([current] ++ (drop (length toRemove) stack))
    | otherwise = return output
        where isStronger operator = ((opPrecedence current) <= (opPrecedence operator))

evalExpr :: [[Char]] -> [Double] -> IO (Double)
evalExpr [] output = return (output !! 0)
evalExpr (current: input) output
    | (isFloat current == True) = evalExpr input (output ++ [stringToFloat current])
    | (isInList current listValidOp == True)
        && (length output >= 2) = do
                                    res <- compute first second current
                                    evalExpr input ((take ((length output) - 2) output) ++ [res])
    | otherwise = exitWith (ExitFailure 84)
    where { first = output !! ((length output) - 2)
            ; second = output !! ((length output) - 1)}

run :: [[Char]] -> IO ()
run (command:_) = do
    let parsedCommand = parseInput (words $ intersperse ' ' command) []
    sortedCommand <- shuntingYard parsedCommand [] []
    case sortedCommand of
        [] -> exitWith (ExitFailure 84)
        _ -> do { ret <- evalExpr sortedCommand []
                ; printf "%.2f\n" (ret)}