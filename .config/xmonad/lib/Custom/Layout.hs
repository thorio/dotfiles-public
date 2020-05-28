{-# LANGUAGE PartialTypeSignatures #-}
{-# OPTIONS_GHC -Wno-partial-type-signatures #-}

module Custom.Layout (
    Custom.Layout.hook
) where

import qualified Custom.Workspaces as Workspaces
import qualified XMonad.Layout.Dwindle as Dwindle
import qualified XMonad.Layout.Tabbed as Tabbed
import XMonad ( Window, (|||), Tall(Tall) )
import XMonad.Hooks.ManageDocks ( Direction2D(R), avoidStruts )
import XMonad.Layout.Decoration
import XMonad.Layout.NoBorders ( smartBorders, noBorders )
import XMonad.Layout.PerWorkspace ( onWorkspaces )
import XMonad.Layout.Renamed ( named )
import XMonad.Layout.Spacing ( spacingRaw, Border(Border), Spacing )
import XMonad.Layout.LimitWindows ( limitWindows )

------------------------------------------------------------------------

hook :: _ Window
hook = smartBorders $ avoidStruts
    $ onWorkspaces [Workspaces.primary, Workspaces.secondary, Workspaces.misc] (dwindle ||| tabs)
    $ onWorkspaces [Workspaces.web, Workspaces.chat, Workspaces.auxiliary] (tabs ||| tall)
    $ tall
    where
        dwindle = gaps $ named "dwnd" $ limitWindows 8 $ Dwindle.Dwindle R Dwindle.CW 1 0
        tall = gaps $ Tall 1 0.03 0.6
        tabs = named "tabs" $ noBorders $ Tabbed.tabbed Tabbed.shrinkText theme

theme :: Theme
theme = Tabbed.def {
    decoHeight = 20,
    activeBorderWidth = 0,
    inactiveBorderWidth = 0,
    activeColor = "#202020",
    inactiveColor = "#202020",
    activeTextColor = "#8abeb7",
    inactiveTextColor = "#666666",
    fontName = "xft:Hack Nerd Font:size=10:antialias=true"
}

------------------------------------------------------------------------

gaps :: l a -> ModifiedLayout Spacing l a
gaps = spacingRaw True (Border 2 2 2 2) True (Border 2 2 2 2) True

-- borders :: l a -> ModifiedLayout _ l a
-- borders = lessBorders OnlyLayoutFloat
