module Custom.Event (
    Custom.Event.hook
) where

import qualified Custom.Loggers.Alert as Alert
import Graphics.X11.Xlib.Extras (Event)
import XMonad (X)
import Data.Semigroup (All)
import XMonad.Util.Hacks (fixSteamFlicker)
import XMonad.ManageHook ( (<+>) )

------------------------------------------------------------------------

hook :: Event -> X All
hook = Alert.eventHook <+> fixSteamFlicker
