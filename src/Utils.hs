module Utils
    ( isInList,
        isFloat,
        listDigit,
        listValidChar,
        listValidOp,
        opPrecedence,
        stringToFloat
    ) where

import Text.Read

listValidChar :: [[Char]]
listValidChar = ["+", "-", "*", "/", "^", "(", ")", "."]

listValidOp :: [[Char]]
listValidOp = ["+", "-", "*", "/", "^"]

listDigit :: [[Char]]
listDigit = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

opPrecedence :: [Char] -> Int
opPrecedence op =
    case op of
        "+" -> 2
        "-" -> 2
        "*" -> 3    
        "/" -> 3
        "^" -> 4
        _ -> 0

stringToFloat :: String -> Double
stringToFloat str = read str :: Double

isInList :: [Char] -> [[Char]] -> Bool
isInList _ [] = False
isInList current (x:xs)
    | (current == x) = True
    | otherwise = isInList current xs

isFloat :: [Char] -> Bool
isFloat "." = True
isFloat num
    | ((readMaybe num :: Maybe Double) == Nothing) = False
    | otherwise = True