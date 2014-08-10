require 'optparse'

# render markdown from command line.
options = {}
parser = OptionParser.new do |opts|
  opts.banner = "Usage: #{__FILE__} MARKDOWN_FILE [options]"

  opts.on('-m', '--markdown MARKDOWN_PROCESSOR', "Select a markdown processor") do |processor|
    raise 'No markdown processor given' if processor.nil?
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

parser.parse!

=begin
markdown = options[:markdown] || :redcarpet
file = ARGV[0]
raise "No markdown file." if file.nil?
doc = Markdown.new(markdown).to_document(File.read(file))

# TODO: write markdown to file
html_filename = "#{file.split('.').first}.html"
html_file = File.new(html_filename, 'w')

html_file.write doc
html_file.close
=end

