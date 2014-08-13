# converter class for markdown
module Markdown
  class Parse
    # parser - markdown processor
    #   - kramdown
    #   - redcarpet
    #   - maruku
    #   - rdiscount
    def initialize(parser)
      @parser = parser
    end

    # takes markdown and returns html (as a string)
    #
    # content - markdown content
    def to_html(content)
      case @parser
      when :kramdown, 'kramdown'
        require 'kramdown'
        Kramdown::Document.new(content).to_html
      when :redcarpet, 'redcarpet'
        require 'redcarpet'
        markdown = Redcarpet::Markdown.new(
          Redcarpet::Render::HTML,
          smart: true,
          no_intra_emphasis: true,
          fenced_code_blocks: true,
          autolink: true,
          tables: true,
          with_toc_data: true
        )

        # add smartypants support
        Redcarpet::Render::SmartyPants.render markdown.render(content)
      when :rdiscount, 'rdiscount'
        require 'rdiscount'
        RDiscount.new(content).to_html
      when :gfm, :github, :github_markdown, 'gfm', 'github_markdown'
        require 'github/markdown'
        GitHub::Markdown.render(content)
      end
    end

    HTML = <<-TEXT
<!DOCTYPE html>
<html>
  <head>
    <title>Document</title>
    <style>
    {{theme}}
    </style>
  </head>

  <body>
  {{content}}
  </body>
</html>
    TEXT

    def to_document(content)
      theme_file = Dir['*theme.css'].first || 'nothing'
      theme_fail = !File.exist?(theme_file)
      theme = File.read(theme_file) unless theme_fail

      html = to_html(content)
      html = HTML.gsub('{{content}}', html)
      html.gsub('{{theme}}', theme) unless theme_fail
    end
  end
end