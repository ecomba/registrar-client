module Registrar
  class NameServer
    include Comparable

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def <=> other
      self.name <=> other.name
    end
  end
end
