class Property

    attr_accessor :address, :value, :bedrooms, :year
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @address = options['address']
        @value = options['value'].to_i
        @bedrooms = options['bedrooms'].to_i
        @year = options['year'].to_i
    end

end