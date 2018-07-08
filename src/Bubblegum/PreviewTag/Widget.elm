module Bubblegum.PreviewTag.Widget exposing (view)

{-| A flexible listbox widget to preview multiple tags with the following features:

  - Supports multiple languages as well as right to left writing.

Please have a look at the main [documentation](https://github.com/flarebyte/bubblegum-ui-preview-tag) for more details about the possible settings.

@docs view

-}

import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.PreviewTag.Adapter as TagAdapter
import Bubblegum.PreviewTag.BulmaHelper exposing (contentBox, mainBox, previewTextList)
import Bubblegum.PreviewTag.Helper exposing (getListContent)
import Bubblegum.PreviewTag.VocabularyHelper
    exposing
        ( getContentId
        , getSelectedAppearance
        , getUserLanguage
        , isUserRightToLeft
        )
import Html exposing (Html)


{-| View for the widget

    attr key value = { id = Nothing , key = key, facets = [], values = [value]}

    adapter =  = { onMouseOver = OnMouseOver }

    userSettings = { attributes = [attr ui_userLanguage "en-US"] }
    settings = { attributes = [attr ui_selectedAppearance "ui:selected-appearance/bulleted-list"] ++ getExampleAttributes }
    state = { attributes = [ attrs ui_selected [ "id:suggestion:1", "id:suggestion:3" ]] }

    view adapter userSettings settings state

-}
view : TagAdapter.Model msg -> SettingsEntity.Model -> SettingsEntity.Model -> StateEntity.Model -> Html msg
view adapter userSettings settings state =
    mainBox adapter
        (getUserLanguage userSettings)
        (isUserRightToLeft userSettings)
        (getContentId state)
        [ contentBox
            [ previewTextList (getSelectedAppearance settings) (getListContent settings state)
            ]
        ]
