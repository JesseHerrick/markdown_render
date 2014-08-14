# Markdown Render
> A themed command line markdown processor.

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

## API
Behind the command line interface is an awesome API! Check it out.

```ruby
require 'markdown_render'
parser = Markdown::Parse.new(:kramdown, css_string)

# render markdown to a full HTML document
parser.to_document(markdown_content_string)

# render just to HTML
parser.to_html(markdown_content_string)
```