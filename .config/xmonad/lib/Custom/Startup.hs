module Custom.Startup (
    Custom.Startup.hook
) where

import qualified XMonad.Util.ExtensibleState as State
import qualified Custom.Workspaces as Workspaces
import XMonad.Actions.OnScreen ( greedyViewOnScreen )
import XMonad ( X, windows, ExtensionClass (initialValue, extensionType), StateExtension (PersistentExtension) )
import XMonad.StackSet (view, greedyView)
import Control.Monad (unless)
import Custom.Util.Once (doOnce)

------------------------------------------------------------------------

hook :: X ()
hook = doOnce focusWorkspaces

focusWorkspaces :: X ()
focusWorkspaces = do
    windows (greedyViewOnScreen 1 Workspaces.auxiliary)
    windows (greedyViewOnScreen 0 Workspaces.primary)
    windows $ greedyView Workspaces.primary
