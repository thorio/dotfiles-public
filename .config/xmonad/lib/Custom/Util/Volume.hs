module Custom.Util.Volume (
    increase,
    decrease,
    toggleMute,
    alert,
) where

import qualified Custom.Loggers.Alert as Alert
import XMonad
import XMonad.Util.Run

------------------------------------------------------------------------

increase :: Int -> X ()
increase n = pamixerSet ["--increase", show n] >> alert

decrease :: Int -> X ()
decrease n = pamixerSet ["--decrease", show n] >> alert

toggleMute :: X ()
toggleMute = pamixerSet ["--toggle-mute"] >> alert

alert :: X ()
alert = do
    a <- runProcessWithInput "pamixer" ["--get-volume", "--get-mute"] ""
    Alert.push ("<fn=1>\xfa7d</fn> " ++ formatAlert a) 2

------------------------------------------------------------------------

formatAlert :: String -> String
formatAlert s = format (head . words $ s) (last . words $ s)
    where
        format :: String -> String -> String
        format "false" p = p ++ "%"
        format "true" p = "muted"
        format s p = "error"


pamixerSet :: [String] -> X ()
pamixerSet args = runProcessWithInput "pamixer" args "" >> mempty
