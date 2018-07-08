module WidgetTestData exposing (..)

{-| Tests data to be used by the unit tests which are themselves generated automatically.
-}

import Bubblegum.Entity.Attribute as Attribute
import Bubblegum.Entity.SettingsEntity as SettingsEntity
import Bubblegum.Entity.StateEntity as StateEntity
import Bubblegum.PreviewTag.Adapter as Adapter
import Bubblegum.PreviewTag.Vocabulary exposing (..)
import Bubblegum.PreviewTag.Widget as Widget
import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, constant, int, intRange, list, string)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (Selector)
import Bubblegum.PreviewTag.VocabularyHelper exposing(enumSelectedAppearance)


type TestMsg
    = OnMouseOver String


biggerThanSmall : Int
biggerThanSmall =
    50


biggerThanMedium : Int
biggerThanMedium =
    200


biggerThanVeryLarge : Int
biggerThanVeryLarge =
    200000


defaultAdapter : Adapter.Model TestMsg
defaultAdapter =
    { onMouseOver = OnMouseOver
    }


defaultUserSettings : SettingsEntity.Model
defaultUserSettings =
    { attributes =
        [ attr ui_userLanguage "es-ES"
        ]
    }


defaultSettings : SettingsEntity.Model
defaultSettings =
    { attributes =
        [attr ui_selectedAppearance "ui:selected-appearance/bulleted-list"]
            ++ getExampleAttributes
    }


defaultState : StateEntity.Model
defaultState =
    { attributes =
        [ attrs ui_selected [ "id:suggestion:1", "id:suggestion:3" ]
        ]
    }


viewWidgetWithSettings : SettingsEntity.Model -> Html.Html TestMsg
viewWidgetWithSettings settings =
    Widget.view defaultAdapter defaultUserSettings settings defaultState


viewWidgetWithUserSettings : SettingsEntity.Model -> Html.Html TestMsg
viewWidgetWithUserSettings userSettings =
    div []
        [ Widget.view defaultAdapter userSettings defaultSettings defaultState
        ]


viewWidgetWithState : StateEntity.Model -> Html.Html TestMsg
viewWidgetWithState state =
    div []
        [ Widget.view defaultAdapter defaultUserSettings defaultSettings state
        ]


findComponent : List Selector -> Html.Html TestMsg -> Expectation
findComponent selectors html =
    html |> Query.fromHtml |> Query.findAll selectors |> Query.count (Expect.equal 1)


findWarningDiv : Html.Html TestMsg -> Expectation
findWarningDiv html =
    html |> Query.fromHtml |> Query.findAll [ Selector.class "warning" ] |> Query.count (Expect.atLeast 1)

-- Language used by the user

createLanguageOrRandom : Int -> String
createLanguageOrRandom number =
    if number == 1 then
        "es"
    else
        createString number


withUserSettingsUserLanguage : Int -> SettingsEntity.Model
withUserSettingsUserLanguage value =
    { attributes =
        [ attr ui_userLanguage (createLanguageOrRandom value)
        ]
    }


fuzzyUserLanguage : Fuzzer Int
fuzzyUserLanguage =
    intRange 1 1


fuzzyNotUserLanguage : Fuzzer Int
fuzzyNotUserLanguage =
    intRange 50 1000


selectorsUserLanguage : List Selector
selectorsUserLanguage =
    [ Selector.class "bubblegum-preview-tag__widget", Selector.attribute (Attributes.lang "es") ]


selectorsNotUserLanguage : List Selector
selectorsNotUserLanguage =
    [ Selector.class "bubblegum-preview-tag__widget"
    , Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:within-string-chars-range:(1,32)")
    ]


-- Whether the user is using right to left

createTrueOrRandom : Int -> String
createTrueOrRandom number =
    if number == 1 then
        "true"
    else
        createString number


withUserSettingsUserRightToLeft : Int -> SettingsEntity.Model
withUserSettingsUserRightToLeft value =
    { attributes =
        [ attr ui_userRightToLeft (createTrueOrRandom value)
        ]
    }


fuzzyUserRightToLeft : Fuzzer Int
fuzzyUserRightToLeft =
    intRange 1 1


fuzzyNotUserRightToLeft : Fuzzer Int
fuzzyNotUserRightToLeft =
    intRange 3 1000


selectorsUserRightToLeft : List Selector
selectorsUserRightToLeft =
    [ Selector.class "bubblegum-preview-tag__widget", Selector.attribute (Attributes.dir "rtl") ]


selectorsNotUserRightToLeft : List Selector
selectorsNotUserRightToLeft =
    [ Selector.class "bubblegum-preview-tag__widget"
    , Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:bool")
    ]

-- The selected tags for the field

withStateSelected : Int -> StateEntity.Model
withStateSelected value =
    { attributes =
        [ attr ui_selected ("id:suggestion:" ++ toString value)
        ]
    }


fuzzySelected : Fuzzer Int
fuzzySelected =
    intRange 1 9


fuzzyNotSelected : Fuzzer Int
fuzzyNotSelected =
    intRange 100 400


selectorsSelected : List Selector
selectorsSelected =
    [ Selector.tag "ul",  Selector.class "bulleted-list" ]

-- The appearance of the selected field
withSettingsSelectedAppearance: String -> SettingsEntity.Model
withSettingsSelectedAppearance value = {
    attributes = [
        attr ui_selectedAppearance value
    ]
 }

fuzzySelectedAppearance : Fuzzer String
fuzzySelectedAppearance = Fuzz.oneOf (enumSelectedAppearance |> List.filter (String.contains "ordered-list")|> List.map constant )

fuzzyNotSelectedAppearance : Fuzzer String
fuzzyNotSelectedAppearance = string

selectorsSelectedAppearance : List Selector
selectorsSelectedAppearance = [ Selector.tag "ol" ]

selectorsNotSelectedAppearance : List Selector
selectorsNotSelectedAppearance = [ Selector.class "bubblegum-preview-tag__input",
    Selector.attribute (attribute "data-bubblegum-warn" "unsatisfied-constraint:") ]

-- The unique id of the content
withStateContentId: Int -> StateEntity.Model
withStateContentId value = {
    attributes = [
        attr ui_contentId (createString value)
    ]
 }

fuzzyContentId : Fuzzer Int
fuzzyContentId = constant 1

selectorsContentId : List Selector
selectorsContentId = [ Selector.class "bubblegum-preview-tag__widget" ]

-- private


attr : String -> String -> Attribute.Model
attr key value =
    { id = Nothing
    , key = key
    , facets = []
    , values = [ value ]
    }


attrs : String -> List String -> Attribute.Model
attrs key values =
    { id = Nothing
    , key = key
    , facets = []
    , values = values
    }


ipsum =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer mauris dolor, suscipit at nulla a, molestie scelerisque lectus. Nullam quis leo a felis auctor mollis ac vel turpis. Praesent eleifend ut sem et hendrerit. Vivamus sagittis tortor ipsum, eu suscipit lectus accumsan a. Vivamus elit ante, ornare vitae sem at, ornare eleifend nibh. Mauris venenatis nunc sit amet leo aliquam, in ornare quam vehicula. Morbi consequat ante sed felis semper egestas. Donec efficitur suscipit ipsum vitae ultrices. Quisque eget vehicula odio. Aliquam vitae posuere mauris. Nulla ac pulvinar felis. Integer odio libero, vulputate in erat in, tristique cursus erat."


createString : Int -> String
createString size =
    if size > 500 then
        String.repeat size "A"
    else
        String.left size ipsum


attri : String -> String -> List String -> Attribute.Model
attri id key values =
    { id = Just id
    , key = key
    , facets = []
    , values = values
    }


suggestion : Int -> List String -> List Attribute.Model
suggestion uid infoTags =
    let
        id =
            "id:suggestion:" ++ toString uid

        label =
            "label" ++ toString uid

        description =
            "description" ++ toString uid

        warningTags =
            if uid % 3 == 0 then
                [ "attention" ]
            else
                []

        dangerTags =
            if uid % 5 == 0 then
                [ "risk" ]
            else
                []
    in
    [ attri id ui_constituentLabel [ label ]
    , attri id ui_constituentDescription [ description ]
    ]


getExampleAttributes : List Attribute.Model
getExampleAttributes =
        suggestion 1 [ "info a", "info a 2" ]
        ++ suggestion 2 [ "info b" ]
        ++ suggestion 3 [ "info c", "info2" ]
        ++ suggestion 4 [ "info d" ]
        ++ suggestion 5 []
        ++ suggestion 6 [ "info f" ]
        ++ suggestion 7 [ "info g" ]
        ++ suggestion 8 [ "info h" ]
        ++ suggestion 9 [ "info i" ]
        ++ suggestion 10 [ "info j" ]
