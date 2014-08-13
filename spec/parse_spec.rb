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
    all_processors do |p|
      expect(p).to respond_to(:to_html)
    end
  end
end