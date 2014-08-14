require 'mercenary'
require 'colorize'
require 'markdown_render'

Mercenary.program(:markdown_render) do |p|
  p.version Markdown::VERSION
  p.description 'A simple, themed Markdown processor.'
  p.syntax 'markdown <command> [options]'

  p.command(:build) do |c|
    c.syntax 'build <file> [options]'
    c.description 'Process the Markdown and write it to a file.'

    # c.option 'theme', '-t THEME_NAME', '--theme THEME_NAME', 'Pass a theme to the processor.'
    c.option 'processor', '-p PROCESSOR', '--processor PROCESSOR', 'Specify a Markdown processor.'

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
      parser = Markdown::Parse.new(processor, theme)
      html = parser.to_document File.read(file)
      md_filename = file.split('.').first + '.html'
      File.open(md_filename, 'w') do |file|
        file.write html
      end

      # some friendly output
      puts "#{file.green} => #{md_filename.green}"
      puts "using #{theme_file.split('.').first.blue} as a theme"
      puts "markdown processor: #{processor.to_s.red}"
    end
  end

  p.default_command(:build)
end
