#import "../../common/theme/type.typ": 字体, 字号
#import "../../common/utils/numbering.typ": heading_numbering
#import "utils/counters.typ": cover_end_before_counter, cover_end_after_counter
#import "config/constants.typ": special_chapter_titles

#let conf(content) = {
  let show_if_after_cover_end_before(content) = {
    locate(loc => {
      if cover_end_before_counter.at(loc).first() > 0 {
        content
      }
    })
  }
  let show_if_after_cover_end_after(content) = {
    locate(loc => {
      if cover_end_after_counter.at(loc).first() > 0 {
        content
      }
    })
  }

  set page(
    paper: "a4",
    margin: (top: 3.8cm, left: 3cm, right: 3cm, bottom: 3cm),
  )

  set page(header: {
    show_if_after_cover_end_before[
      #set align(center)
      #set text(font: 字体.宋体, size: 字号.小五, baseline: 6pt)
      #set par(leading: 0em)
      #text[
        哈尔滨工业大学本科毕业论文（设计）
      ]
      #line(length: 100%)
      #v(2pt, weak: true)
      #line(length: 100%, stroke: 0.1mm)
    ]
  })

  set page(footer: {
    set align(center)
    locate(loc => {
      show_if_after_cover_end_after[
        #text()[
          \- #counter(page).at(loc).first() \-
        ]
      ]
    })
  })

  show heading: it => {
    let format_heading(it: none, font: none, size: none, display_numbering: true) = {
      set text(font: font, size: size)

      if display_numbering {
        text(weight: "regular")[
          #counter(heading).display()
        ]
      }
      if it != none {
        if display_numbering {
          h(0.75em)
        }
        text[
          #it.body.text
        ]
      }

      v(0.5em)
    }

    set par(first-line-indent: 0em)

    if it.level == 1 {
      format_heading(it: it, font: 字体.黑体, size: 字号.二号, display_numbering: false)
    } else if it.level == 2 {
      align(center)[

        #if it.body.text in special_chapter_titles.values() {
          set text(spacing: 1em)
          format_heading(it: it, font: 字体.黑体, size: 字号.小二, display_numbering: false)
          counter(heading).update(0)
        } else {
          format_heading(it: it, font: 字体.黑体, size: 字号.小二)
        }
      ]
    } else if it.level == 3 {
      format_heading(it: it, font: 字体.黑体, size: 字号.小三)
    } else if it.level == 4 {
      format_heading(it: it, font: 字体.黑体, size: 字号.小四)
    }
  }

  set heading(numbering: heading_numbering)

  set par(first-line-indent: 2em, leading: 1em, justify: true)

  set text(font: 字体.宋体, size: 字号.小四)

  show figure.where(kind: "table"): set figure.caption(position: top)

  content
}