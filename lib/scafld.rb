require "scafld/version"
require "scafld/scafld"

module Scafld
  # Your code goes here...

  def self.from_file(file)
    content = open(file).read
    Scafld.new(content)
  end

  def self.from_s(content)
    Scafld.new(content)
  end
end
