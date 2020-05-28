module Custom.Util.Once (
    doOnce,
) where

import qualified XMonad.Util.ExtensibleState as State
import XMonad ( X, windows, ExtensionClass (initialValue, extensionType), StateExtension (PersistentExtension) )
import Control.Monad (unless)

------------------------------------------------------------------------

newtype DoOnce = DoOnce { done :: Bool }
    deriving (Read, Show)

instance ExtensionClass DoOnce where
    initialValue = DoOnce False
    extensionType = PersistentExtension

doOnce :: X () -> X ()
doOnce f = do
    done <- State.gets done
    unless done $ do
        f
        State.put (DoOnce True)
