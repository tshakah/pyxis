module Stories.Chapters.FormGrid exposing (docs)

import Components.Form as Form
import Components.Form.FieldSet as FieldSet
import Components.Form.Grid.Column as Column
import Components.Form.Grid.Row as Row
import ElmBook
import ElmBook.Chapter
import Html exposing (Html)
import Html.Attributes


docs : ElmBook.Chapter.Chapter sharedState
docs =
    "Form/Grid"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.withComponentList componentsList
        |> ElmBook.Chapter.render """

Forms are a set of input components whose purpose is to allow data entry.
The basic structure of a form is made up of some basic elements: form, fieldset, grid, row column and item.
For a visual rapresentation of grid, you can check the
[Storybook](https://react-staging.prima.design/?path=/story/components-form-%F0%9F%9A%A7-overview--page) documentation.

Below an example of full form grid configuration:

<component with-label="Form Anatomy" />

```
Form.create
    |> Form.withFieldSets
        [ FieldSet.create
            |> FieldSet.withHeader
                [ Row.default
                    |> Row.withColumns
                        [ Column.oneSpan
                            |> Column.withContent (columnContent "Form header")
                        ]
                ]
            |> FieldSet.withContent
                [ Row.default
                    |> Row.withColumns
                        [ Column.oneSpan
                            |> Column.withContent (columnContent "Form content")
                        ]
                , Row.default
                    |> Row.withColumns
                        [ Column.oneSpan
                            |> Column.withContent (columnContent "Form content")
                        ]
                ]
            |> FieldSet.withFooter
                [ Row.default
                    |> Row.withColumns
                        [ Column.oneSpan
                            |> Column.withContent (columnContent "Form footer")
                        ]
                ]
        ]
    |> Form.render
```


## Form
Form element represents a document section containing interactive controls for submitting information.
Each form can include multiple Fieldset.

```
form: Html msg
form =
    Form.create
        |> Form.withFieldSets []
        |> Form.render
```

## Fieldset
Fieldset element is used to group several controls as well as labels within a web form.

Every fieldset is composed by three (optional) macro area: `header`, `content` and `footer`.

```
fieldset: Html msg
fieldset =
    FieldSet.create
        |> FieldSet.withHeader []
        |> FieldSet.withContent []
        |> FieldSet.withFooter []
        |> FieldSet.render
```

## Row
Form Row is used to define the width of grid and to group the columns inside it.

### Default Row

Default dimensions are 100% of its base container.
It is recommended to use this setting for horizontal forms on single or multiple rows.

<component with-label="Row Default" />

```
row : Html msg
row =
    Row.default
        |> Row.withColumns []
        |> Row.render
```

### Large Row

Large dimensions (720px) are recommended to use this setting for vertical development forms with the possibility
of placing components not belonging to the same group side by side.

<component with-label="Row Large" />

```
row : Html msg
row =
    Row.large
        |> Row.withColumns []
        |> Row.render
```

### Large Small

Small dimensions (360px) are recommended to use this setting for vertical development
forms with the possibility of tiling only components of the same group.

<component with-label="Row Small" />

```
row : Html msg
row =
    Row.small
        |> Row.withColumns []
        |> Row.render
```

## Column
Form Column is used to align horizontally and define the width of a `form-item`.
Each row can have a maximum of `6` columns based on its size. Normally the columns are divided into equal fractions `fr`.
Anyways, it is possible to set the span of the columns up to a maximum of `5`,
in this way it is possible to have a column wide `1` and a column wide `5`.

### One Span

<component with-label="Row with one oneSpan column" />

```
rowWithOnecolumn : Html msg
rowWithOnecolumns =
    Row.small
        |> Row.withColumns
            [ Column.oneSpan
                |> Column.withContent (columnContent "1 span")
            ]
        |> Row.render
```

<component with-label="Row with two oneSpan columns" />

```
rowWithTwocolumns : Html msg
rowWithTwocolumns =
    Row.small
        |> Row.withColumns
            [ Column.oneSpan
                |> Column.withContent (columnContent "1 span")
            , Column.oneSpan
                |> Column.withContent (columnContent "1 span")
            ]
        |> Row.render
```


### Two Span

<component with-label="Row with one oneSpan column and one twoSpan column" />

```
rowWithTwocolumns : Html msg
rowWithTwocolumns =
    Row.small
        |> Row.withColumns
            [ Column.oneSpan
                |> Column.withContent (columnContent "1 span")
            , Column.twoSpan
                |> Column.withContent (columnContent "2 span")
            ]
        |> Row.render
```

### Three Span

<component with-label="Row with one oneSpan column and one threeSpan column" />

```
rowWithTwocolumns : Html msg
rowWithTwocolumns =
    Row.small
        |> Row.withColumns
            [ Column.oneSpan
                |> Column.withContent (columnContent "1 span")
            , Column.threeSpan
                |> Column.withContent (columnContent "3 span")
            ]
        |> Row.render
```

### Four Span

<component with-label="Row with one oneSpan column and one fourSpan column" />

```
rowWithTwocolumns : Html msg
rowWithTwocolumns =
    Row.small
        |> Row.withColumns
            [ Column.oneSpan
                |> Column.withContent (columnContent "1 span")
            , Column.fourSpan
                |> Column.withContent (columnContent "4 span")
            ]
        |> Row.render
```

### Five Span

<component with-label="Row with one oneSpan column and one fiveSpan column" />

```
rowWithTwocolumns : Html msg
rowWithTwocolumns =
    Row.small
        |> Row.withColumns
            [ Column.oneSpan
                |> Column.withContent (columnContent "1 span")
            , Column.fiveSpan
                |> Column.withContent (columnContent "5 span")
            ]
        |> Row.render
```
"""


componentsList : List ( String, Html (ElmBook.Msg state) )
componentsList =
    [ ( "Form Anatomy"
      , Form.create
            |> Form.withFieldSets
                [ FieldSet.create
                    |> FieldSet.withHeader
                        [ Row.default
                            |> Row.withColumns
                                [ Column.oneSpan
                                    |> Column.withContent (columnContent "Form header")
                                ]
                        ]
                    |> FieldSet.withContent
                        [ Row.default
                            |> Row.withColumns
                                [ Column.oneSpan
                                    |> Column.withContent (columnContent "Form content")
                                ]
                        , Row.default
                            |> Row.withColumns
                                [ Column.oneSpan
                                    |> Column.withContent (columnContent "Form content")
                                ]
                        ]
                    |> FieldSet.withFooter
                        [ Row.default
                            |> Row.withColumns
                                [ Column.oneSpan
                                    |> Column.withContent (columnContent "Form footer")
                                ]
                        ]
                ]
            |> Form.render
      )
    , ( "Row Default"
      , Row.default
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "Row default")
                ]
            |> Row.render
      )
    , ( "Row Large"
      , Row.large
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "Row large")
                ]
            |> Row.render
      )
    , ( "Row Small"
      , Row.small
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "Row small")
                ]
            |> Row.render
      )
    , ( "Row with one oneSpan column"
      , Row.default
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "1 span")
                ]
            |> Row.render
      )
    , ( "Row with two oneSpan columns"
      , Row.default
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "1 span")
                , Column.oneSpan
                    |> Column.withContent (columnContent "1 span")
                ]
            |> Row.render
      )
    , ( "Row with one oneSpan column and one twoSpan column"
      , Row.default
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "1 span")
                , Column.twoSpan
                    |> Column.withContent (columnContent "2 span")
                ]
            |> Row.render
      )
    , ( "Row with one oneSpan column and one threeSpan column"
      , Row.default
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "1 span")
                , Column.threeSpan
                    |> Column.withContent (columnContent "3 span")
                ]
            |> Row.render
      )
    , ( "Row with one oneSpan column and one fourSpan column"
      , Row.default
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "1 span")
                , Column.fourSpan
                    |> Column.withContent (columnContent "4 span")
                ]
            |> Row.render
      )
    , ( "Row with one oneSpan column and one fiveSpan column"
      , Row.default
            |> Row.withColumns
                [ Column.oneSpan
                    |> Column.withContent (columnContent "1 span")
                , Column.fiveSpan
                    |> Column.withContent (columnContent "5 span")
                ]
            |> Row.render
      )
    ]


columnContent : String -> Html msg
columnContent content =
    Html.div
        [ Html.Attributes.classList
            [ ( "bg-neutral-95", True )
            , ( "padding-s", True )
            , ( "radius-s", True )
            , ( "text-s-book", True )
            ]
        ]
        [ Html.text content ]
