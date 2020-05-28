module Custom.Util.Backlight (
    increaseBrightness,
    decreaseBrightness,
    setColorLight,
    setColorDark,
    setSourceHdmi1,
    setSourceHdmi2,
    setSourceDp,
) where

import qualified Custom.Loggers.Alert as Alert
import Data.Maybe
import Text.Read
import XMonad
import XMonad.Util.Run

------------------------------------------------------------------------

increaseBrightness :: Int -> X ()
increaseBrightness n = modBrightness "+" n >> alert

decreaseBrightness :: Int -> X ()
decreaseBrightness n = modBrightness "-" n >> alert

setColorDark :: X ()
setColorDark = setColor 50

setColorLight :: X ()
setColorLight = setColor 100

setSourceHdmi1 :: X ()
setSourceHdmi1 = setSource "17"

setSourceHdmi2 :: X ()
setSourceHdmi2 = setSource "18"

setSourceDp :: X ()
setSourceDp = setSource "15"

------------------------------------------------------------------------

vcpBrightness = "10"
vcpGainRed = "16"
vcpGainGreen = "18"
vcpGainBlue = "1A"
vcpSourceInput = "60"
vpcBusPrimary = 0
vpcBusAuxiliary = 4

setColor :: Int -> X ()
setColor n = foldx setvcp' [vcpGainRed, vcpGainGreen, vcpGainBlue]
    where setvcp' p = setvcp vpcBusPrimary [p, show n]

modBrightness :: String -> Int -> X ()
modBrightness mod n = setvcpAll [vcpBrightness, mod, show n]

setSource :: String -> X ()
setSource source = setvcp vpcBusPrimary [vcpSourceInput, source]

setvcp :: Int -> [String] -> X ()
setvcp bus args = ddcutil bus args' >> mempty
    where args' = ["--noverify", "setvcp"] ++ args

setvcpAll :: [String] -> X ()
setvcpAll args = do
    ddcutil vpcBusPrimary args'
    ddcutil vpcBusAuxiliary args'
    mempty
    where args' = ["--noverify", "setvcp"] ++ args

ddcutil :: Int -> [String] -> X [Char]
ddcutil bus args = runProcessWithInput "ddcutil" args' ""
    where args' = ["--bus", show bus, "--sleep-multiplier", "0.1"] ++ args

alert :: X ()
alert = do
    a <- ddcutil vpcBusPrimary ["--brief", "getvcp", vcpBrightness]
    Alert.push ("<fn=1>\xf5dd</fn> " ++ formatAlert a) 2
    where
        formatAlert s = words s !! 3 ++ "%"

foldx :: (p -> X ()) -> [p] -> X ()
foldx f = foldr (\p x -> x >> f p) mempty
