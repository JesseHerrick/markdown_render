require 'spec_helper'

describe Markdown do
  before do
    @processors = [:kramdown, :redcarpet, :rdiscount, :gfm]

    def all_processors
      @processors.each do |processor|
        yield Markdown.new(processor)
      end
    end
  end
  it 'should work with all markdown processors' do
    # @processors.each do |processor|
    #   expect(Markdown.new(processor)).to respond_to(:to_html)
    # end
    all_processors do |p|
      expect(p).to respond_to(:to_html)
    end
  end

  context '#to_html' do
    it "render DF's syntax properly" do
      all_processors do |p|
        syntax = '# This'
        expect(p.to_html(syntax)).to match(%r{(<h1 id="this">This</h1>|<h1>This</h1>)})
      end
    end
  end
end