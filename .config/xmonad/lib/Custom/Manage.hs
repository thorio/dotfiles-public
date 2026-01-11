module Custom.Manage (
    Custom.Manage.hook
) where

import qualified Custom.Scratchpads as Scratchpads
import qualified Custom.Workspaces as Workspaces
import qualified XMonad.StackSet as W
import XMonad
import XMonad.Hooks.ManageHelpers
import XMonad.Util.NamedScratchpad ( namedScratchpadManageHook )

------------------------------------------------------------------------

hook :: ManageHook
hook = composeAll
    [
        transience',
        namedScratchpadManageHook Scratchpads.scratchpads,
        isModal <||> isDialog --> doCenterFloat,

        -- layout
        className =? "Xmessage" --> doCenterFloat,
        title =? "bindings" --> doRectFloat (centeredRect 0.3 0.725),

        (className =? "Hydrus Client") ==> [
            wmName =? "main" --> doShiftAndView Workspaces.secondary,
            wmName =? "hydrus client media viewer" --> doFullFloat,
            wmName =? "manage tags" --> doFloat,
            wmName =? "review files to import" --> doFloat
        ],
        className =? "hydrus-comic-preview" --> doFullFloat,

        -- workspace shifting
        className =? "looking-glass-client" --> doShift Workspaces.auxiliary,
        className =? "steam" --> doShift Workspaces.secondary,
        className =? "Code" --> doShiftAndView Workspaces.secondary,
        appName =? "schildichat" --> doShiftAndView Workspaces.chat,
        className =? "librewolf" <&&> appName =? "Navigator" --> doShiftAndView Workspaces.web,
        className =? "Plex" --> doShiftAndView Workspaces.secondary <+> doFullFloat
    ]

(==>) :: (Monad m, Monoid a, Monoid (m a)) => m Bool -> [m a] -> m a
p ==> f = p --> composeAll f

doShiftAndView :: WorkspaceId -> ManageHook
doShiftAndView workspace = doShift workspace <+> doF (W.greedyView workspace)

centeredRect :: Rational -> Rational -> W.RationalRect
centeredRect w h = W.RationalRect x y w h
    where
        x = (1 - w) / 2
        y = (1 - h) / 2

wmName :: Query String
wmName = stringProperty "WM_NAME"

isModal :: Query Bool
isModal = isInProperty "_NET_WM_STATE" "_NET_WM_STATE_MODAL"
