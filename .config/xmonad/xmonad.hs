{-# LANGUAGE PartialTypeSignatures #-}
{-# OPTIONS_GHC -Wno-partial-type-signatures #-}

import qualified Custom.Bindings as Bindings
import qualified Custom.Event as Event
import qualified Custom.Layout as Layout
import qualified Custom.Log as Log
import qualified Custom.Loggers.Alert as Alert
import qualified Custom.Manage as Manage
import qualified Custom.Startup as Startup
import qualified Custom.StatusBar as StatusBar
import qualified Custom.Workspaces as Workspaces
import XMonad
import XMonad.Hooks.EwmhDesktops ( ewmhFullscreen, ewmh )
import XMonad.Hooks.ManageDocks ( docks )
import XMonad.Hooks.StatusBar ( withSB )

------------------------------------------------------------------------

main :: IO ()
main = xmonad $ docks $ ewmh $ ewmhFullscreen $ withSB StatusBar.config $ myConfig

myConfig :: XConfig _
myConfig = def {
    focusFollowsMouse = True,
    clickJustFocuses = False,
    borderWidth = 0,
    modMask = mod4Mask,
    normalBorderColor = "#224a77",
    focusedBorderColor = "#7aa6da",

    terminal = "alacritty",
    workspaces = Workspaces.workspaces,
    keys = Bindings.bindings,
    startupHook = Startup.hook,
    layoutHook = Layout.hook,
    manageHook = Manage.hook,
    handleEventHook = Event.hook,
    logHook = Log.hook
}
