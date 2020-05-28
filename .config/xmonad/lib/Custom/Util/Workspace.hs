module Custom.Util.Workspace (
    nextNonEmpty,
    prevNonEmpty
) where

import XMonad ( X, windows, gets, XState (windowset) )
import XMonad.Actions.CycleWS
import qualified XMonad.StackSet as W
import XMonad.Util.WorkspaceCompare ( WorkspaceSort, filterOutWs, getSortByIndex )
import qualified Custom.Workspaces as Workspaces
import Control.Monad (unless, when)

------------------------------------------------------------------------

-- from https://github.com/altercation/dotfiles-tilingwm/blob/31e23a75eebdedbc4336e7826800586617d7d27d/.xmonad/xmonad.hs#L1145
nextNonEmpty :: X ()
nextNonEmpty = cycleNonEmpty Next

prevNonEmpty :: X ()
prevNonEmpty = cycleNonEmpty Prev

------------------------------------------------------------------------

cycleNonEmpty :: Direction1D -> X ()
cycleNonEmpty d = do
    isAux <- curIsAux
    if isAux
        then nextScreen >> cycle >> prevScreen
        else cycle
    where
        cycle = findWorkspace workspaces d (hiddenWS :&: Not emptyWS) 1 >>= windows . W.view
        workspaces = fmap (.filterOutWs ["NSP", Workspaces.auxiliary]) getSortByIndex

curIsAux :: X Bool
curIsAux = do
    ws <- gets windowset
    let cur = W.tag $ W.workspace $ W.current ws

    return $ cur == "aux"
