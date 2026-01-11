module Custom.Scratchpads (
    scratchpads,
    terminal,
    musicPlayer,
    iotPanel,
    tray,
    notes,
) where

import XMonad hiding (terminal)
import qualified XMonad.StackSet as W
import XMonad.Util.NamedScratchpad ( NamedScratchpad(NS) )
import XMonad.Layout.NoBorders ( hasBorder )
import XMonad.Hooks.ManageHelpers ( doRectFloat )
import Data.Ratio ((%))
import XMonad.Hooks.ManageDebug (manageDebug)

------------------------------------------------------------------------

scratchpads :: [NamedScratchpad]
scratchpads = [ terminal, musicPlayer, iotPanel, tray, notes ]

terminal :: NamedScratchpad
terminal = NS "terminal" spawn find manage
    where
        spawn = "alacritty -t scratchpad"
        find = title =? "scratchpad"
        manage = centered 0.9 0.9

musicPlayer :: NamedScratchpad
musicPlayer = NS "musicPlayer" spawn find manage
    where
        spawn = "flatpak run com.plexamp.Plexamp"
        find = className =? "Plexamp"
        manage = centeredPixels 400 600

iotPanel :: NamedScratchpad
iotPanel = NS "iotPanel" spawn find manage
    where
        spawn = "WEBKIT_DISABLE_DMABUF_RENDERER=0 rism --title hass-panel https://hass.chirality.de/lovelace?kiosk"
        find = title =? "hass-panel"
        manage = centered 0.39 0.5

tray :: NamedScratchpad
tray = NS "tray" spawn find manage
    where
        spawn = "trayer --SetDockType false --edge top --align center --widthtype request --padding 70 " ++
            "--iconspacing 4 --transparent true --alpha 0 --tint 0x212121 --height 20"
        find = className =? "trayer"
        manage = mempty

notes :: NamedScratchpad
notes = NS "notes" spawn find manage
    where
        spawn = "obsidian"
        find = className =? "obsidian"
        manage = centered 0.98 0.98

------------------------------------------------------------------------

centered :: Rational -> Rational -> ManageHook
centered w h = doRectFloat $ W.RationalRect x y w h
    where
        x = (1 - w) / 2
        y = (1 - h) / 2

centeredPixels :: Integer -> Integer -> ManageHook
centeredPixels w h = curScreenSize >>= centeredPixels' w h

centeredPixels' :: Integer -> Integer -> Rectangle -> ManageHook
centeredPixels' w h r = centered sw sh
    where
        sw = w % fromIntegral (rect_width r)
        sh = h % fromIntegral (rect_height r)

curScreenSize :: Query Rectangle
curScreenSize = liftX $ withWindowSet $ return . screenRect . W.screenDetail . W.current

