module ArgsManagement
    ( checkArgs
    ) where

import Utils ( listValidChar, listValidOp, listDigit, isInList )

checkEmptyParenthesis :: Char -> String -> Integer
checkEmptyParenthesis '(' (')':_) = 84
checkEmptyParenthesis _ _ = 0

countParenthesisLoop :: String -> Integer -> (String, Integer)
countParenthesisLoop [] index = ("", index)
countParenthesisLoop ('(':str) index = if checkEmptyParenthesis '(' str == 84
                                    then ("", -1)
                                    else countParenthesisLoop str (index+1)
countParenthesisLoop (')':str) index = countParenthesisLoop str (index-1)
countParenthesisLoop (_:str) index
    | index < 0 = ("", -1)
    | otherwise = countParenthesisLoop str index 

countParenthesis :: String -> Int
countParenthesis str = case index of
                            0 -> 0
                            _ -> 84
                            where (_, index) = countParenthesisLoop str 0

checkLegalChar :: String -> Int
checkLegalChar [] = 0
checkLegalChar (' ':xs) = checkLegalChar xs
checkLegalChar (x:xs)
    | (isInList [x] listValidChar == False)
        && (isInList [x] listDigit) == False = 84
    | otherwise = checkLegalChar xs

checkForNoNumber :: String -> Int
checkForNoNumber [] = 84
checkForNoNumber (x:xs)
    | (isInList [x] listDigit == False) = checkForNoNumber xs
    | otherwise = 0

isEnchained :: String -> Bool
isEnchained (x:_)
    | (isInList [x] listValidOp == True) = True
    | otherwise = False

checkForEnchainedOp :: String -> Int
checkForEnchainedOp [] = 0
checkForEnchainedOp (x:xs)
    | (isInList [x] listValidOp == True)
        && (isEnchained xs == True) = 84
    | otherwise = checkForEnchainedOp xs

checkArgs :: [String] -> Int
checkArgs [] = 84
checkArgs (command:args)
    | (length args + 1 /= 1) = 84
    | (length command == 0) = 84
    | (countParenthesis command == 84) = 84
    | (checkLegalChar command == 84) = 84
    | (checkForNoNumber command == 84) = 84
    | (checkForEnchainedOp command == 84) = 84
    | otherwise = 0