require_relative("../db/sql_runner")

class Hall

  attr_reader :id, :hall, :max_customers
  attr_accessor  :actual_customers

  def initialize( options )
    @id = options['id'].to_i
    @hall = options['hall']
    @max_customers = options['max_customers'].to_i
    @actual_customers = options['actual_customers'].to_i
  end

  def save()
    sql = "INSERT INTO halls (hall, max_customers, actual_customers)
    VALUES ('#{ @hall }', #{ @max_customers }, #{ @actual_customers }) RETURNING id"
    hall = SqlRunner.run( sql ).first
    @id = hall['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM halls"
    return  Hall.get_many(sql)
  end

  def self.get_many(sql)
    halls = SqlRunner.run(sql)
    halls_objects = halls.map { |hall| Hall.new (hall)}
    return halls_objects
  end

  def self.get_hall_id(hall)
    sql = "  SELECT id FROM halls WHERE hall = '#{hall}';"
    return SqlRunner.run( sql )[0]['id']

  end

  def self.get_max(hall)
    sql = "SELECT max_customers FROM halls WHERE hall = '#{hall}';" 
    return SqlRunner.run( sql )[0]['max_customers']
  end

  def self.get_actual(hall)
    sql = "SELECT actual_customers FROM halls WHERE hall = '#{hall}';" 
    return SqlRunner.run( sql )[0]['actual_customers']
  end


def self.check_max(hall)
  sql = "SELECT * FROM halls WHERE hall = '#{hall}';" 
  max_customers = SqlRunner.run( sql )[0]['max_customers']
  actual_customers = SqlRunner.run( sql )[0]['actual_customers']
  return max_customers==actual_customers ? true :false
end

end