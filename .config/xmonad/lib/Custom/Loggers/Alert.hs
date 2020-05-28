module Custom.Loggers.Alert (
    set,
    clear,
    push,
    logger,
    logOver,
    eventHook,
) where

import XMonad

import XMonad.Util.Loggers
import qualified XMonad.Util.ExtensibleState as State
import XMonad.Util.Timer
import Data.Monoid

------------------------------------------------------------------------

newtype TidState = TID TimerId
instance ExtensionClass TidState where initialValue = TID 0

newtype AlertState = AlertState { text :: Maybe String }
instance ExtensionClass AlertState where initialValue = AlertState Nothing

------------------------------------------------------------------------

set :: String -> X ()
set s = State.put (AlertState $ Just s) >> runLogHook

clear :: X ()
clear = State.put (AlertState Nothing) >> runLogHook

push :: String -> Rational -> X ()
push s t = State.put (AlertState $ Just s) >> runLogHook >> scheduleClear t

logOver :: Logger -> Logger
logOver l = logger .| l .| logConst ""

logger :: Logger
logger = State.gets text

eventHook :: Event -> X All
eventHook e = do
  (TID t) <- State.get
  handleTimer t e $ clear >> return Nothing
  return $ All True

------------------------------------------------------------------------

runLogHook :: X ()
runLogHook = ask >>= logHook.config

scheduleClear :: Rational -> X ()
scheduleClear n = startTimer n >>= State.put . TID
