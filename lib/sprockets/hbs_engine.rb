require 'tilt'
require 'json'

module Sprockets
  class HbsEngine < Tilt::Template
    def self.default_mime_type
      "application/javascript"
    end

    protected

    def prepare
    end

    def evaluate(scope, locals, &block)
      "this.HBS || (this.HBS = {}); this.HBS['#{scope.logical_path}'] = Handlebars.compile(#{data.to_json});"
    end
  end
end
