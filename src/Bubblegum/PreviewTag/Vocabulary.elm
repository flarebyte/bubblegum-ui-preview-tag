module Bubblegum.PreviewTag.Vocabulary exposing (..)

{-| List of keys used for the settings

    **Generated** by generate-vocabulary.py

-}


{-| Language of the content. (String)
-}
ui_contentLanguage : String
ui_contentLanguage =
    "ui:content-language"


{-| Whether the content requires right to left. (Bool)
-}
ui_contentRightToLeft : String
ui_contentRightToLeft =
    "ui:content-right-to-left"


{-| Language used by the user. (String)
-}
ui_userLanguage : String
ui_userLanguage =
    "ui:user-language"


{-| Whether the user is using right to left. (Bool)
-}
ui_userRightToLeft : String
ui_userRightToLeft =
    "ui:user-right-to-left"


{-| The selected tags for the field. (List String)
-}
ui_selected : String
ui_selected =
    "ui:selected"


{-| The appearance of the selected field. (String)
-}
ui_selectedAppearance : String
ui_selectedAppearance =
    "ui:selected-appearance"


{-| Label of the constituent. (String)
-}
ui_constituentLabel : String
ui_constituentLabel =
    "ui:constituent-label"


{-| Description of the constituent. (String)
-}
ui_constituentDescription : String
ui_constituentDescription =
    "ui:constituent-description"
