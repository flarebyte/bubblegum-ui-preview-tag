module WidgetCreateTests exposing (..)

{-| Unit tests for testing the view of the Widget

    **Generated** by generate-vocabulary.py
    
-}
import Test exposing (..)
import WidgetTestData exposing (..)


suite : Test
suite =
    describe "The Widget module"
        [ describe "Widget.view"
            [

                fuzz fuzzyUserLanguage "Correct settings for Language used by the user" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserLanguage value)
                    |> findComponent selectorsUserLanguage

             , fuzz fuzzyNotUserLanguage "Wrong settings for Language used by the user" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserLanguage value) 
                    |> findComponent selectorsNotUserLanguage

                , fuzz fuzzyUserRightToLeft "Correct settings for Whether the user is using right to left" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserRightToLeft value)
                    |> findComponent selectorsUserRightToLeft

             , fuzz fuzzyNotUserRightToLeft "Wrong settings for Whether the user is using right to left" <|
                \value -> viewWidgetWithUserSettings (withUserSettingsUserRightToLeft value) 
                    |> findComponent selectorsNotUserRightToLeft

                , fuzz fuzzySelected "Correct settings for The selected tags for the field" <|
                \value -> viewWidgetWithState (withStateSelected value)
                    |> findComponent selectorsSelected

                , fuzz fuzzySelectedAppearance "Correct settings for The appearance of the selected field" <|
                \value -> viewWidgetWithSettings (withSettingsSelectedAppearance value)
                    |> findComponent selectorsSelectedAppearance

              , fuzz fuzzyNotSelectedAppearance "Wrong settings for The appearance of the selected field" <|
                \value -> viewWidgetWithSettings (withSettingsSelectedAppearance value)
                    |> findWarningDiv           

                , fuzz fuzzyContentId "Correct settings for The unique id of the content" <|
                \value -> viewWidgetWithState (withStateContentId value)
                    |> findComponent selectorsContentId

            ]
        ]
