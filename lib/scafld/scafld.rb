module Scafld
  class Scafld
    attr_accessor :token_start, :token_end
    attr_reader :token_status, :cleanup_status
    def initialize(content)
      @content = content
      @token_start = "{{"
      @token_end = "}}"
      @token_status = :on
      @cleanup_status = :on
    end

    def replace(token,content)
      @content.gsub!(wrap_token(token), content)
      self
    end

    def replace_once(token,content)
      @content.sub!(wrap_token(token), content)
      self
    end

    def tokens(status)
      @token_status = status
      self
    end

    def cleanup(status)
      @cleanup_status = status
      self
    end

    def save_file(file_name)
      open(file_name, "w") do |file|
        file.write(build)
      end
    end

    def build
      #only cleanup if using tokens
      if @cleanup_status == :on and @token_status == :on
        @content.gsub(wrap_token(".*?"), "")
      else
        @content
      end
    end

    private
    def wrap_token(token)
      if @token_status == :on
        /#{@token_start}#{token}#{@token_end}/
      else
        /#{token}/
      end
    end
  end
end
