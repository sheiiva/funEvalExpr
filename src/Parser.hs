module Parser
    ( parseInput
    ) where

import Data.List

import Utils

concatFloat :: [[Char]] -> [[Char]] -> [[Char]]
concatFloat [] dest = dest
concatFloat (x:xs) dest
    | (isFloat x == False) = concatFloat xs (dest ++ [x])
    | otherwise = concatFloat (drop (length op) ([x] ++ xs)) (dest ++ concatOp)
        where { op = takeWhile isFloat ([x] ++ xs)
             ; concatOp = [intercalate "" op] }

concatNeg :: [[Char]] -> [[Char]] -> Int -> [[Char]]
concatNeg input output i
    | (i == (length input)) = output 
    | (currentChar == "-" && i == 0) =
            concatNeg input (output ++ [currentChar ++ (input !! 1)]) (i + 2)
    | (currentChar == "-" && (i /= (length input) - 1)) =
        if (isInList previousChar listValidChar) && (isFloat nextChar)
            then concatNeg input (output ++ [currentChar ++ nextChar]) (i + 2)
        else concatNeg input (output ++ [currentChar]) (i + 1)
    | otherwise = concatNeg input (output ++ [currentChar]) (i + 1)
    where { currentChar = input !! i
            ; previousChar = input !! (i - 1)
            ; nextChar = input !! (i + 1) }

parseInput :: [[Char]] -> [[Char]] -> [[Char]]
parseInput sparse stack = concatNeg (concatFloat sparse stack) [] 0