# Markdown Render
> A themed command line markdown processor.

## Why?
Every once in a while, I need to write a document for something or another and I'm forced to use a WYSIWG editor. I write [my blog](https://jesseherrick.io/blog) in beautiful markdown using [Jekyll](http://jekyllrb.com), so why can't my documents be the same way? Markdown Render allows you to write your documents in markdown and print/share them as styled HTML. *Down with WYSIWG!*

## Usage
```shell
$ markdown build MARKDOWN.md
# => MARKDOWN.html
```

The markdown `build` command takes one argument: a markdown file. Here's the full usage info: (which you can get by calling `markdown build -h`)

```
Usage:
  markdown build <file> [options]

Options:
-p PROCESSOR, --processor PROCESSOR  Specify a Markdown processor.
        -h, --help         Show this message
        -v, --version      Print the name and version
        -t, --trace        Show the full backtrace when an error occurs
```

## Theming
`markdown_render` looks for themes in the same directory as the markdown file passed as an argument. The theme should end in `-theme.css`. For example, if I have this layout:

```
.
├── fun-theme.css
└── fun.md
```

The renderer will take the contents of `fun-theme.css` and inject them into the head of your HTML document inside a `<style>` tag. This means that you won't need to include the CSS theming file in your HTML document --- which is awesome.

### How to Build a Theme
I assume that if you wish to build a theme that you know the elements of a markdown document. But here's what a standard theme should include styling for:

* Body Text (`p`)
* Headers (`h1` through `h3` at least)
* Blockquotes (`blockquote`)
* Lists (`ul` & `ol` + `li`)
* Code (`code`)
* Code Blocks (`pre code`)
* Links (`a`)
* Images (`img`)
* Emphasized Text (`em`)
* Bold Text (`strong`)

**Note**: A responsive viewport is automatically put into the HTML.

## API
Behind the command line interface is an awesome API! Check it out.

```ruby
require 'markdown_render'
parser = Markdown::Parse.new(:kramdown, optional_css_string)

# render markdown to a full HTML document
parser.to_document(markdown_content_string)

# render just to HTML
parser.to_html(markdown_content_string)
```
