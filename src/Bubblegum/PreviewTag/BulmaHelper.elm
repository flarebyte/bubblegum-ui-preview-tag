module Bubblegum.PreviewTag.BulmaHelper
    exposing
        ( appendHtmlIfSuccess
        , contentBox
        , mainBox
        , previewTextList
        )

{-| The Bulma css framework is used for styling the widget.

See <https://bulma.io/documentation/>

This helper facilitates the creation of Bulma styled html elements.

-}

import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.PreviewTag.Helper exposing (ListItem)
import Bubblegum.PreviewTag.VocabularyHelper exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes exposing (..)
import List
import String exposing (join)


{-| Append some html code when the outcome is successful otherwise hide a warning in the html
-}
appendHtmlIfSuccess : (a -> Html.Html msg) -> Outcome a -> List (Html.Html msg) -> List (Html.Html msg)
appendHtmlIfSuccess ifSuccess outcome htmlList =
    case outcome of
        None ->
            htmlList

        Warning warn ->
            htmlList ++ [ div [ Attributes.class "is-invisible warning" ] [ text warn ] ]

        Valid success ->
            htmlList ++ [ ifSuccess success ]


{-| Append a list of html code when the outcome is successful otherwise hide a warning in the html
-}
appendListHtmlIfSuccess : (a -> List (Html.Html msg)) -> Outcome a -> List (Html.Html msg) -> List (Html.Html msg)
appendListHtmlIfSuccess ifSuccess outcome htmlList =
    case outcome of
        None ->
            htmlList

        Warning warn ->
            htmlList ++ [ div [ Attributes.class "is-invisible warning" ] [ text warn ] ]

        Valid success ->
            htmlList ++ ifSuccess success


{-| Append a html attribute when the outcome is successful otherwise hide a warning in the html
-}
appendAttributeIfSuccess : (a -> Attribute msg) -> Outcome a -> List (Attribute msg) -> List (Attribute msg)
appendAttributeIfSuccess ifSuccess outcome attributes =
    case outcome of
        None ->
            attributes

        Warning warn ->
            attributes ++ [ attribute "data-bubblegum-warn" warn ]

        Valid success ->
            attributes ++ [ ifSuccess success ]



-- Various helpers


asClass : List String -> Attribute msg
asClass list =
    List.reverse list |> join " " |> class


asClass2 : String -> String -> Attribute msg
asClass2 a b =
    [ b, a ] |> asClass


rtlOrLtr : Bool -> String
rtlOrLtr value =
    if value then
        "rtl"
    else
        "ltr"


mainBox : Outcome String -> Outcome Bool -> List (Html msg) -> Html msg
mainBox language rtl list =
    div
        ([ class "bubblegum-preview-tag__widget box is-marginless is-paddingless is-shadowless" ]
            |> appendAttributeIfSuccess lang language
            |> appendAttributeIfSuccess dir (rtl |> Outcome.map rtlOrLtr)
        )
        list


contentBox : List (Html msg) -> Html msg
contentBox list =
    div [ class "content" ] list


getWarningMessage : Outcome a -> String
getWarningMessage outcome =
    case outcome of
        Warning msg ->
            msg

        _ ->
            ""


previewTextListItem : ListItem -> Html msg
previewTextListItem listItem =
    li ([] |> appendAttributeIfSuccess title listItem.description)
        ([] |> appendHtmlIfSuccess text listItem.label)


previewTextListItems : List ListItem -> List (Html msg)
previewTextListItems list =
    List.map previewTextListItem list


previewTextListType : EnumSelectedAppearance -> String
previewTextListType listPreviewType =
    case listPreviewType of
        UiSelectedAppearanceOrderedListDecimal ->
            "1"

        UiSelectedAppearanceOrderedListAlphabeticUpper ->
            "A"

        UiSelectedAppearanceOrderedListAlphabeticLower ->
            "a"

        UiSelectedAppearanceOrderedListRomanUpper ->
            "I"

        UiSelectedAppearanceOrderedListRomanLower ->
            "i"

        UiSelectedAppearanceOrderedListGreekLower ->
            ""

        UiSelectedAppearanceBulletedList ->
            "disc"

        UiSelectedAppearanceTodoListChecked ->
            ""

        UiSelectedAppearanceTodoListUnchecked ->
            ""

        UiSelectedAppearanceFeatureChecked ->
            ""

        UnknownSelectedAppearance ->
            ""


previewTextList : Outcome EnumSelectedAppearance -> Outcome (List ListItem) -> Html msg
previewTextList outcomeListPreviewType outcome =
    let
        listPreviewType =
            outcomeListPreviewType |> Outcome.toMaybe |> Maybe.withDefault UnknownSelectedAppearance

        liList =
            [] |> appendListHtmlIfSuccess previewTextListItems outcome
    in
    case listPreviewType of
        UiSelectedAppearanceOrderedListDecimal ->
            liList |> ol [ class "ordered-list--decimal", type_ (previewTextListType listPreviewType) ]

        UiSelectedAppearanceOrderedListAlphabeticUpper ->
            liList |> ol [ class "ordered-list--alphabetic-upper", type_ (previewTextListType listPreviewType) ]

        UiSelectedAppearanceOrderedListAlphabeticLower ->
            liList |> ol [ class "ordered-list--alphabetic-lower", type_ (previewTextListType listPreviewType) ]

        UiSelectedAppearanceOrderedListRomanUpper ->
            liList |> ol [ class "ordered-list--roman-upper", type_ (previewTextListType listPreviewType) ]

        UiSelectedAppearanceOrderedListRomanLower ->
            liList |> ol [ class "ordered-list--roman-lower", type_ (previewTextListType listPreviewType) ]

        UiSelectedAppearanceOrderedListGreekLower ->
            liList |> ol [ class "ordered-list--greek-lower" ]

        UiSelectedAppearanceBulletedList ->
            liList |> ul [ class "bulleted-list" ]

        UiSelectedAppearanceTodoListChecked ->
            liList |> ul [ class "todo-list--checked" ]

        UiSelectedAppearanceTodoListUnchecked ->
            liList |> ul [ class "todo-list--unchecked" ]

        UiSelectedAppearanceFeatureChecked ->
            liList |> ul [ class "feature--checked" ]

        UnknownSelectedAppearance ->
            div [ class "is-invisible warning" ] [ text (getWarningMessage outcome) ]
