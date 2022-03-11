module Stories.Chapters.Introduction exposing (docs)

import ElmBook.Chapter


docs : ElmBook.Chapter.Chapter sharedState
docs =
    "Introduction"
        |> ElmBook.Chapter.chapter
        |> ElmBook.Chapter.render """

Pyxis is Prima's Design System. A collection of tools, rules and guidelines to design, develop and tell our brand.

![image info](https://react-staging.prima.design/static/media/banner.c4b4f1bf.png)

A unique resource to work in harmony and improve the user and customer experience.
"""
