module Custom.Bindings (
    bindings,
) where

import qualified Custom.Scratchpads as Scratchpads
import qualified Custom.Util.Backlight as Backlight
import qualified Custom.Util.Volume as Volume
import qualified Custom.Util.Workspace as Workspace
import qualified Custom.Workspaces as Workspaces
import qualified Data.Map as M
import System.Exit ( exitSuccess )
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig ( mkKeymap )
import XMonad.Util.NamedScratchpad ( namedScratchpadAction, NamedScratchpad (name) )
import XMonad.Util.Run ( safeSpawn, safeSpawnProg )
import XMonad.Actions.CycleWS (swapNextScreen, shiftNextScreen)

------------------------------------------------------------------------

bindings :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
bindings conf = mkKeymap conf $
    [
        -- launch
        ("C-M1-t", safeSpawnProg "alacritty"), -- open a new terminal
        ("C-M1-w", safeSpawnProg "librewolf"), -- open a new librewolf window
        ("C-M1-q", safeSpawn "librewolf" ["-private-window"]), -- open a new private librewolf window
        ("C-M1-e", safeSpawnProg "nemo"), -- open a new file explorer window
        ("<Print>", safeSpawn "flameshot" ["gui"]), -- take a screenshot
        ("C-M-<Space>", safeSpawnProg "dmenu_run"), -- launch dmenu

        -- scratchpads
        ("C-M1-s", scratchpad Scratchpads.terminal), -- toggle the terminal scratchpad
        ("C-M1-a", scratchpad Scratchpads.musicPlayer), -- toggle the music player scratchpad
        ("C-M1-d", scratchpad Scratchpads.iotPanel), -- toggle the iot-panel scratchpad
        ("C-M1-x", scratchpad Scratchpads.tray), -- toggle the system tray
        ("C-M1-z", scratchpad Scratchpads.notes), -- toggle the notes scratchpad

        -- window
        ("M-w", kill), -- kill the active window
        ("M-d", windows W.focusDown), -- move focus to the next window
        ("M-a", windows W.focusUp), -- move focus to the previous window
        ("M-S-d", windows W.swapDown), -- swap the focused window with the next window
        ("M-S-a", windows W.swapUp), -- swap the focused window with the previous window
        ("M-`", windows W.swapMaster), -- swap the focused window with the master window
        ("M-s", withFocused $ windows . W.sink), -- push focused window back into tiling
        ("M-f", withFocused $ windows . floatFull), -- float and fullscreen focused window

        -- layout
        ("M-<Space>", sendMessage NextLayout), -- rotate through the available layout algorithms
        ("M-S-<Space>", setLayout $ XMonad.layoutHook conf), -- reset layouts to default
        ("M-<Left>", sendMessage Shrink), -- shrink the master area
        ("M-<Right>", sendMessage Expand), -- expand the master area
        ("M-<Up>", sendMessage (IncMasterN 1)), -- increment the number of windows in master area
        ("M-<Down>", sendMessage (IncMasterN (-1))), -- decrement the number of windows in master area

        -- screen
        ("S-<XF86MonBrightnessUp>", Backlight.increaseBrightness 100), -- increase the brightness to maximum
        ("S-<XF86MonBrightnessDown>", Backlight.decreaseBrightness 100), -- decrease the brightness to minimum
        ("<XF86MonBrightnessUp>", Backlight.increaseBrightness 10), -- increase the brightness by 10%
        ("<XF86MonBrightnessDown>", Backlight.decreaseBrightness 10), -- decrease the brightness by 10%
        ("M1-<XF86MonBrightnessUp>", Backlight.increaseBrightness 1), -- increase the brightness by 1%
        ("M1-<XF86MonBrightnessDown>", Backlight.decreaseBrightness 1), -- decrease the brightness by 1%
        ("C-<XF86MonBrightnessUp>", Backlight.setColorLight), -- reset color profile to default
        ("C-<XF86MonBrightnessDown>", Backlight.setColorDark), -- set color profile to darker
        ("C-M1-<Insert>", Backlight.setSourceHdmi2), -- set primary monitor source to HDMI2
        ("C-M1-<Home>", Backlight.setSourceDp), -- set primary monitor source to DP
        ("C-M1-<Page_Up>", Backlight.setSourceHdmi1), -- set primary monitor source to HDMI1

        -- volume
        ("<XF86AudioMute>", Volume.toggleMute), -- toggle volume mute
        ("S-<XF86AudioRaiseVolume>", Volume.increase 100), -- increase the volume to maximum
        ("S-<XF86AudioLowerVolume>", Volume.decrease 100), -- decrease the volume to minimum
        ("<XF86AudioRaiseVolume>", Volume.increase 10), -- increase the volume by 10%
        ("<XF86AudioLowerVolume>", Volume.decrease 10), -- decrease the volume by 10%
        ("M1-<XF86AudioRaiseVolume>", Volume.increase 1), -- increase the volume by 1%
        ("M1-<XF86AudioLowerVolume>", Volume.decrease 1), -- decrease the volume by 1%

        -- xmonad
        ("M-q", spawn "xmonad --recompile && xmonad --restart"), -- recompile and restart xmonad
        ("M-C-S-q", io exitSuccess), -- quit xmonad
        ("M-/", safeSpawn "alacritty" ["-t", "bindings", "-e", ".config/xmonad/scripts/show-bindings.sh"]), -- show keybindings

        -- system
        ("M-l", safeSpawn "loginctl" ["lock-session"]), -- lock the X session

        -- workspaces
        ("M-C-<Right>", Workspace.nextNonEmpty), -- show the next non-empty workspace
        ("M-C-<Left>", Workspace.prevNonEmpty), -- show the previous non-empty workspace
        ("M-<Tab>", swapNextScreen) -- swap screen's workspaces
    ]
    ++
    [
        -- M-[1 .. 9] => switch to workspace
        -- M-S-[1 .. 9] => move window to workspace
        ("M-" ++ m ++ k, windows $ f i)
        | (i, k) <- zip Workspaces.workspaces (map show ([1 .. 9] ++ [0] :: [Int]))
        , (f, m) <- [(W.greedyView, ""), (W.shift, "S-")]
    ]

------------------------------------------------------------------------

floatFull :: Ord a => a -> W.StackSet i l a s sd -> W.StackSet i l a s sd
floatFull a = W.float a rect
    where rect = W.RationalRect 0 0 1 1

scratchpad :: NamedScratchpad -> X ()
scratchpad = namedScratchpadAction Scratchpads.scratchpads . name
