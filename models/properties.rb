require('pg')
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

    def save()
        db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
        sql = "INSERT INTO properties (address, value, bedrooms, year)
        VALUES ($1, $2, $3, $4) RETURNING id"
        values = [@address, @value, @bedrooms, @year]
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]["id"].to_i()
        db.close()
    end

end