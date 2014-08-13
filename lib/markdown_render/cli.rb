require 'optparse'

# render markdown from command line.
options = {}
parser = OptionParser.new do |opts|
  opts.banner = <<-BANNER
Usage: markdown-render MARKDOWN_FILE [options]"

Example: 
  markdown-render MARKDOWN_FILE -m kramdown
  # => FILENAME.html
  
  BANNER

  opts.on('-m', '--markdown PROCESSOR', "Select a markdown processor") do |processor|
    options[:markdown] = case processor
    when /kramdown/i then :kramdown
    when /redcarpet/i then :redcarpet
    when /rdiscount/i then :rdiscount
    when /gfm/i then :gfm
    when /maruku/i then :maruku
    else
      abort "Not a valid markdown processor: #{processor}"
    end
  end

  opts.on('-h', '--help', 'Display help') do
    puts opts
    exit
  end

  opts.on('-v', '--version', 'Display version') do
    puts MarkdownRender::VERSION
  end
end

parser.parse! # parse CLI

def parse_options
markdown = options[:markdown] || :redcarpet # default to redcarpet if no markdown processor is given
file = ARGV[0] # the [markdown] file given as a param
raise "No markdown file." if file.nil? # 
doc = Markdown.new(markdown).to_document(File.read(file))

html_filename = "#{file.split('.').first}.html"
html_file = File.open(html_filename, 'w') do |file|
  file.write doc
  file.close
end

