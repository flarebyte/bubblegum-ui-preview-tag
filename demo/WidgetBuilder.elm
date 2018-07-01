module WidgetBuilder exposing (viewWidget)

import AppModel exposing (AppModel)
import AppMsg exposing (AppMsg(..))
import Bubblegum.PreviewTag.Adapter as Adapter
import Bubblegum.PreviewTag.Widget as Widget
import Html exposing (..)


adapter : Adapter.Model AppMsg
adapter =
    { onMouseOver = OnMouseOver
    }


viewWidget : AppModel -> Html AppMsg
viewWidget model =
    Widget.view adapter model.userSettings model.settings model.state
