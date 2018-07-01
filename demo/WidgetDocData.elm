module WidgetDocData exposing (tagWidgetDoc)

import AttributeDoc exposing (AttributeDoc, Cardinality(..), createKey)
import Bubblegum.PreviewTag.Vocabulary exposing (..)
import KeyDescription exposing (..)
import WidgetDoc exposing (..)
import WidgetPackageJson


{-| Some examples of settings for the demo.

    **Generated** by generate-vocabulary.py

-}
tagWidgetDoc : WidgetDoc
tagWidgetDoc =
    { meta = WidgetPackageJson.meta
    , userSettings =
        [ createKey ui_contentLanguage ZeroOrOne [ "en-GB", "ja", "ar", "zh-CN-SC", "ru-RUS", "es", "it", "fr", "other" ] descContentLanguage
        , createKey ui_contentRightToLeft ZeroOrOne [ "true", "false", "other" ] descContentRightToLeft
        , createKey ui_userLanguage ZeroOrOne [ "en-GB", "ja", "ar", "zh-CN-SC", "ru-RUS", "es", "it", "fr", "other" ] descUserLanguage
        , createKey ui_userRightToLeft ZeroOrOne [ "true", "false", "other" ] descUserRightToLeft
        ]
    , settings =
        [ createKey ui_selectedAppearance ZeroOrOne [ "ui:selected-appearance/ordered-list/decimal", "ui:selected-appearance/ordered-list/alphabetic/upper", "ui:selected-appearance/ordered-list/alphabetic/lower", "ui:selected-appearance/ordered-list/roman/upper", "ui:selected-appearance/ordered-list/roman/lower", "ui:selected-appearance/bulleted-list" ] descSelectedAppearance
        ]
    , stateAttributes =
        [ createKey ui_selected ZeroOrOne [ "id:suggestion:1", "other" ] descSelected
        ]
    }