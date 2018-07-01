module Bubblegum.PreviewTag.VocabularyHelper exposing (..)

{-| Helpers for accessing settings

    **Generated** by generate-vocabulary.py

-}

import Bubblegum.Entity.Outcome as Outcome exposing (..)
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.Entity.Validation as Validation
import Bubblegum.PreviewTag.EntityHelper exposing (..)
import Bubblegum.PreviewTag.HelperLimits exposing (..)
import Bubblegum.PreviewTag.Vocabulary exposing (..)


{-| Language of the content
-}
getContentLanguage : SettingsEntity.Model -> Outcome String
getContentLanguage settings =
    findString ui_contentLanguage settings.attributes
        |> Validation.withinStringCharsRange limitSmallRangeNotEmpty


{-| Whether the content requires right to left
-}
isContentRightToLeft : SettingsEntity.Model -> Outcome Bool
isContentRightToLeft settings =
    findBool ui_contentRightToLeft settings.attributes


{-| Language used by the user
-}
getUserLanguage : SettingsEntity.Model -> Outcome String
getUserLanguage settings =
    findString ui_userLanguage settings.attributes
        |> Validation.withinStringCharsRange limitSmallRangeNotEmpty


{-| Whether the user is using right to left
-}
isUserRightToLeft : SettingsEntity.Model -> Outcome Bool
isUserRightToLeft settings =
    findBool ui_userRightToLeft settings.attributes


{-| The selected tags for the field
-}
getSelected : StateEntity.Model -> Outcome (List String)
getSelected settings =
    findListCompactUri ui_selected settings.attributes


type EnumSelectedAppearance
    = UiSelectedAppearanceOrderedListDecimal
    | UiSelectedAppearanceOrderedListAlphabeticUpper
    | UiSelectedAppearanceOrderedListAlphabeticLower
    | UiSelectedAppearanceOrderedListRomanUpper
    | UiSelectedAppearanceOrderedListRomanLower
    | UiSelectedAppearanceBulletedList
    | UnknownSelectedAppearance


enumSelectedAppearance : List String
enumSelectedAppearance =
    [ "ui:selected-appearance/ordered-list/decimal"
    , "ui:selected-appearance/ordered-list/alphabetic/upper"
    , "ui:selected-appearance/ordered-list/alphabetic/lower"
    , "ui:selected-appearance/ordered-list/roman/upper"
    , "ui:selected-appearance/ordered-list/roman/lower"
    , "ui:selected-appearance/bulleted-list"
    ]


stringToEnumSelectedAppearance : String -> EnumSelectedAppearance
stringToEnumSelectedAppearance value =
    case value of
        "ui:selected-appearance/ordered-list/decimal" ->
            UiSelectedAppearanceOrderedListDecimal

        "ui:selected-appearance/ordered-list/alphabetic/upper" ->
            UiSelectedAppearanceOrderedListAlphabeticUpper

        "ui:selected-appearance/ordered-list/alphabetic/lower" ->
            UiSelectedAppearanceOrderedListAlphabeticLower

        "ui:selected-appearance/ordered-list/roman/upper" ->
            UiSelectedAppearanceOrderedListRomanUpper

        "ui:selected-appearance/ordered-list/roman/lower" ->
            UiSelectedAppearanceOrderedListRomanLower

        "ui:selected-appearance/bulleted-list" ->
            UiSelectedAppearanceBulletedList

        _ ->
            UnknownSelectedAppearance


{-| The appearance of the selected field
-}
getSelectedAppearance : SettingsEntity.Model -> Outcome EnumSelectedAppearance
getSelectedAppearance settings =
    findString ui_selectedAppearance settings.attributes
        |> Validation.matchEnum enumSelectedAppearance
        |> Outcome.map stringToEnumSelectedAppearance


{-| Label of the constituent
-}
getConstituentLabel : SettingsEntity.Model -> String -> Outcome String
getConstituentLabel settings id =
    findStringForId ui_constituentLabel settings.attributes id
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty


{-| Description of the constituent
-}
getConstituentDescription : SettingsEntity.Model -> String -> Outcome String
getConstituentDescription settings id =
    findStringForId ui_constituentDescription settings.attributes id
        |> Validation.withinStringCharsRange limitMediumRangeNotEmpty