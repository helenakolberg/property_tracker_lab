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

    def update()
        db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
        sql = "UPDATE properties SET (address, value, bedrooms, year) = ($1, $2, $3, $4)
            WHERE id = $5"
        values = [@address, @value, @bedrooms, @year, @id]
        db.prepare("update", sql)
        db.exec_prepared("update", values)
        db.close()
    end

    def delete()
        db = PG.connect( {dbname: 'property_tracker', host: 'localhost'} )
        sql = "DELETE FROM properties WHERE id = $1"
        values = [@id]
        db.prepare("delete", sql)
        db.exec_prepared("delete", values)
        db.close()
    end

    def Property.delete_all()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost'} )
        sql = "DELETE FROM properties"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close()
    end

    def Property.find(id)
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost'} )
        sql = "SELECT * FROM properties WHERE id = $1"
        values = [id]
        db.prepare("find", sql)
        results = db.exec_prepared("find", values)
        if results.first == nil
            return
        end
        property = results[0] 
        db.close()
        return Property.new(property)
    end

    def Property.find_property_by_address(address)
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost'} )
        sql = "SELECT * FROM properties WHERE address = $1"
        values = [address]
        db.prepare("find_property_by_address", sql)
        results = db.exec_prepared("find_property_by_address", values)
        if results.first == nil
            return
        end
        property = results[0]
        db.close()
        return Property.new(property)
    end

end