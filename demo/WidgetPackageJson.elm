module WidgetPackageJson exposing (meta)

import PackageJson


meta : PackageJson.Model
meta =
    { version = "1.0.0"
    , summary = "Preview Tag widget for the Bubblegum UI toolkit."
    , repository = "https://github.com/flarebyte/bubblegum-ui-preview-tag.git"
    , license = "BSD3"
    , exposedModules = [ "Bubblegum.PreviewTag.Widget" ]
    }
