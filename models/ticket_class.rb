require_relative("../db/sql_runner")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :purchase_time, :hall_id

  def initialize( options )
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @purchase_time = options['purchase_time']
    @hall_id = options['hall_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, purchase_time, hall_id)
    VALUES ('#{ @customer_id }', '#{ @film_id }', '#{ @purchase_time }', '#{ @hall_id }') RETURNING id"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    return  Ticket.get_many(sql)
  end

  def self.get_many(sql)
   tickets = SqlRunner.run(sql)
   tickets_objects = tickets.map { |ticket| Ticket.new (ticket)}
   return tickets_objects
 end

 def self.delete_all() 
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

def film()
  sql = "SELECT * FROM films WHERE id = #{@film_id};"
  film = SqlRunner.run(sql).first
  return Film.new(location)
end

def customer()
  sql = "SELECT * FROM customers WHERE id = #{@customer_id};"
  customer = SqlRunner.run(sql).first
  return Customer.new(customer)
end

def self.customers(name)
  sql = "
  SELECT id FROM customers WHERE name = '#{name}';
  "

  id = SqlRunner.run( sql )[0]['id']
  puts id
  sql = "
  SELECT c.* FROM customers c
  INNER JOIN tickets t
  ON c.id = t.customer_id 
  WHERE t.customer_id =#{id};
  "
  puts sql 
  return Ticket.get_many(sql)
end


end