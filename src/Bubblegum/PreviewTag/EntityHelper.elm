module Bubblegum.PreviewTag.EntityHelper
    exposing
        ( findBool
        , findIntRange
        , findListCompactUri
        , findListStringForId
        , findString
        , findStringForId
        )

{-| Basic functions for the VocabularyHelper to facilitate the retrieval of data from the configuration
-}

import Bubblegum.Entity.Attribute as Attribute
import Bubblegum.Entity.Outcome as Outcome exposing (Outcome(..))
import Bubblegum.Entity.Validation as Validation
import Bubblegum.PreviewTag.HelperLimits exposing (compactUriLimitList, limitMediumRangeNotEmpty, limitSmallRangeNotEmpty)
import Regex


findIntRange : ( String, String ) -> List Attribute.Model -> Outcome ( Int, Int )
findIntRange keyTuple attributes =
    Attribute.findOutcomeByKeyTuple keyTuple attributes
        |> Validation.asTuple
        |> Validation.asIntTuple
        |> Validation.asIntRange


findString : String -> List Attribute.Model -> Outcome String
findString key attributes =
    Attribute.findOutcomeByKey key attributes |> Validation.asSingle


findStringForId : String -> List Attribute.Model -> String -> Outcome String
findStringForId key attributes id =
    findOutcomeByKeyAndId key attributes id |> Validation.asSingle


findBool : String -> List Attribute.Model -> Outcome Bool
findBool key attributes =
    findString key attributes |> Validation.asBool


findListStringForId : String -> List Attribute.Model -> String -> Outcome (List String)
findListStringForId key attributes id =
    findOutcomeByKeyAndId key attributes id |> Validation.listLessThan compactUriLimitList |> Validation.withinListStringCharsRange limitSmallRangeNotEmpty


findListCompactUri : String -> List Attribute.Model -> Outcome (List String)
findListCompactUri key attributes =
    Attribute.findOutcomeByKey key attributes
        |> Validation.listLessThan compactUriLimitList
        |> Validation.withinListStringCharsRange limitMediumRangeNotEmpty
        |> listMatchCompactUri


{-| Find an attribute by key but also id
findAttributeByKeyAndId "ui:label" models "id:topic/123" -- Just label
-}
findAttributeByKeyAndId : String -> List Attribute.Model -> String -> Maybe Attribute.Model
findAttributeByKeyAndId key attributes id =
    case attributes of
        [] ->
            Nothing

        first :: rest ->
            if first.key == key && first.id == Just id then
                Just first
            else
                findAttributeByKeyAndId key rest id


{-| Find an outcome searching by key
findOutcomeByKeyAndId "ui:label" models "id:topic/123" -- Valid ["some label"]
-}
findOutcomeByKeyAndId : String -> List Attribute.Model -> String -> Outcome (List String)
findOutcomeByKeyAndId key attributes id =
    findAttributeByKeyAndId key attributes id |> Maybe.map .values |> Outcome.fromMaybe


listMatchCompactUri : Outcome (List String) -> Outcome (List String)
listMatchCompactUri outcome =
    Outcome.check (\list -> List.all helperCompactUri list) "unsatisfied-constraint:list-compact-uri" outcome


compactUriRegex : Regex.Regex
compactUriRegex =
    Regex.regex "^[a-z][a-z0-9_.-]{1,15}:\\w[^\\s]*$"


helperCompactUri : String -> Bool
helperCompactUri value =
    Regex.contains compactUriRegex value
