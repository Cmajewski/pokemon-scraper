class Pokemon
    attr_accessor :id, :name, :type, :db

    def initialize (id:, name:, type:, db:)
        @id=id
        @name=name
        @type=type
        @db=db
    end

    def self.new_from_row (row,db)
        self.new(id: row[0], name: row[1], type: row[2],db: db)
    end

    def self.save (name, type, db)
        sql= <<-SQL 
        INSERT INTO pokemon (name, type) VALUES (?, ?)
        SQL
        result=db.execute(sql,name,type)
        last_row=db.execute("SELECT * FROM pokemon WHERE ID= (SELECT MAX(id) FROM pokemon)").first
        self.new_from_row(last_row, db)
      
    end

    def self.find (id, db)

    pokemon_row= db.execute("SELECT * FROM pokemon WHERE id=?", id).first
    self.new_from_row(pokemon_row, db)

    end

end
