require_relative("../db/sql_runner")
# require_relative('./models/ticket_class')


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize ( options)
    @id = options['id'.to_i]
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds ) VALUES ('#{ @name }',#{ @funds }) RETURNING id"
    customer = SqlRunner.run( sql ).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    return Customer.get_many(sql)
  end

  def self.films(name)
    sql = "
    SELECT id FROM customers WHERE name = '#{name}';
    "
    id = SqlRunner.run( sql )[0]['id']
    sql = "
    SELECT f.* FROM films f
    INNER JOIN tickets t
    ON f.id = t.film_id 
    WHERE t.customer_id =#{id};
    "
    return (Film.get_many(sql))
    
  end

  def self.get_funds(name)
    sql = "  SELECT funds FROM customers WHERE name = '#{name}';  "
    return SqlRunner.run( sql )[0]['funds']
    
  end

  def self.get_customer_id(name)
    sql = "
    SELECT id FROM customers WHERE name = '#{name}';
    "
    return SqlRunner.run( sql )[0]['id']

  end

  def self.tickets(name)
    sql = "
    SELECT id FROM customers WHERE name = '#{name}';
    "

    id = SqlRunner.run( sql )[0]['id']
    sql = "
    SELECT t.* FROM tickets t
    INNER JOIN customers c
    ON c.id = t.customer_id 
    WHERE t.customer_id =#{id};
    "
    return Ticket.get_many(sql)
  end

#Refactor of the SqlRunner and return
def self.get_many(sql)
  customers = SqlRunner.run(sql)
  customers_objects = customers.map { |customer| 
    Customer.new(customer)}
    return customers_objects
  end


end