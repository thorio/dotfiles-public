module Custom.StatusBar (
    Custom.StatusBar.config
) where

import qualified Custom.Loggers.Alert as Alert
import Data.Char ( toLower )
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar ( StatusBarConfig, statusBarProp )
import XMonad.Util.Loggers (logTitle)

------------------------------------------------------------------------

config :: StatusBarConfig
config = statusBarProp "xmobar ~/.config/xmobar/xmobar.config" (pure pp)

pp :: PP
pp = filterOutWsPP ["NSP"] $ xmobarPP {
    ppCurrent = color "#b9ca4a",
    ppHidden = color "#7aa6da",
    ppHiddenNoWindows = color "#666666",
    ppVisible = color "#f0c674",
    ppLayout = map toLower . last . words,
    ppSep =  " <fc=#666>|</fc> ",
    ppExtras = [Alert.logOver logTitle],
    ppOrder = \(workspace:layout:_:title:_) -> [workspace, layout, transformTitle title]
}

color :: String -> String -> String
color c = xmobarColor c ""

transformTitle :: String -> String
transformTitle = color "#8abeb7" . shorten 60
