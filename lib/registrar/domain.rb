module Registrar
  class Domain
    attr_reader :name

    attr_accessor :registrant
    attr_accessor :order

    def initialize(name)
      @name = name
    end
  end
end
