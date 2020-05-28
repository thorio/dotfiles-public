module Custom.Log (
    Custom.Log.hook
) where

import qualified Custom.Loggers.Alert as Alert
import XMonad.Hooks.FadeInactive (fadeInactiveLogHook)
import XMonad (composeAll, X)

-----------------------------------------------------------------------

hook :: X ()
hook = mempty
