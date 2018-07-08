# Preview Tag Widget

> Preview Tag widget for the Bubblegum UI toolkit

[![Build Status](https://semaphoreci.com/api/v1/olih/bubblegum-ui-preview-tag/branches/master/badge.svg)](https://semaphoreci.com/olih/bubblegum-ui-preview-tag)

Please check the [demo](https://flarebyte.github.io/bubblegum-ui-preview-tag/)

### Installing Elm packages

There is no dependency.

```
elm-package install flarebyte/bubblegum-ui-preview-tag
```

## Configuring the widget

```
type TestMsg
    = OnMouseOver String

attr: String -> String -> Attribute.Model
attr key value =
     { id = Nothing
    , key = key
    , facets = []
    , values = [value]
    }  

adapter : Adapter.Model TestMsg
adapter =  =
        { onMouseOver = OnMouseOver
        }

userSettings: SettingsEntity.Model
userSettings = {
    attributes = [
        attr "ui:user-language" "en-GB"
    ]
 }

settings: SettingsEntity.Model
settings = {
    attributes = [
        attr "ui:selected-appearance" "ui:selected-appearance/bulleted-list"
        ++ getExampleAttributes
    ]
 }

state: StateEntity.Model
state = {
    attributes = [
        attr ui_selected "id:suggestion:1"
        ]
 }

  Widget.view adapter userSettings settings state 
```

## Widget configuration

### User Settings

 * **ui:user-language** : Language used by the user (String)
 * **ui:user-right-to-left** : Whether the user is using right to left (Bool)

### Settings

* **ui:selected-appearance** : The appearance of the selected field (String)
 
And for each suggestion, you need to describe further:

 * **ui:constituent-label** : Label of the constituent (String)
 * **ui:constituent-description** : Description of the constituent (String)

### State

 * **ui:selected** : The selected tags for the field (List String)
 * **ui:content-id** : The unique id of the content (String)
 
## Technical design

See [Technical design](TECHNICAL_DESIGN.md)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

Managed automatically by [Elm version rules](https://github.com/elm-lang/elm-package#version-rules).

## Authors

* **Olivier Huin** - *Initial work* - [olih](https://github.com/olih)

See also the list of [contributors](https://github.com/flarebyte/bubblegum-ui-preview-tag/graphs/contributors) who participated in this project.

## License

This project is licensed under the BSD 3-Clause License - see the [LICENSE.md](LICENSE) file for details
