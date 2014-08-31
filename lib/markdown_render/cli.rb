require 'mercenary'
require 'colorize'
require 'markdown_render'
require 'listen'

Mercenary.program(:markdown_render) do |p|
  p.version Markdown::VERSION
  p.description 'A simple, themed Markdown processor.'
  p.syntax 'markdown <command> [options]'

  p.command(:build) do |c|
    c.syntax 'build <file> [options]'
    c.description 'Process the Markdown and write it to a file.'

    c.option 'processor', '-p PROCESSOR', '--processor PROCESSOR', 'Specify a Markdown processor.'
    c.option 'watch', '-w', '--watch', 'Watch the markdown file for changes.'

    c.action do |args, options|
      file = args.shift
      processor = (options['processor'] || :kramdown).downcase

      # check that a markdown file is given and exists
      raise 'No Markdown file given.' if file.nil?
      raise 'Markdown file given does not exist.' unless File.exist?(file)

      # find the theme
      theme_file = Dir['*theme.css'].first || 'nothing'
      begin
        theme = File.read(theme_file)
      rescue Errno::ENOENT
        theme = ''
      end

      # parse the markdown
      def parse_markdown(processor, theme)
        parser = Markdown::Parse.new(processor, theme)
        html = parser.to_document File.read(file)
        md_filename = file.split('.').first + '.html'
        File.open(md_filename, 'w') do |f|
          f.write html
        end
      end

      parse_markdown processor, theme
      if options['watch']
        Listen.to(file) do |modified, added, removed|
          puts "#{file} has been regenerated"
          parse_markdown processor, theme
        end.start
      end

      # some friendly output
      puts "#{file.green} => #{md_filename.green}"
      puts "using #{theme_file.split('.').first.blue} as a theme"
      puts "markdown processor: #{processor.to_s.yellow}"
    end
  end

  p.default_command(:build)
end
