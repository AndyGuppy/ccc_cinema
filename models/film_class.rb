require_relative("../db/sql_runner")
# require_relative('./models/ticket_class')


class Film

  attr_reader :id
  attr_accessor :title, :price; :start_time

  def initialize ( options)
    @id = options['id'.to_i]
    @title = options['title']
    @price = options['price']
    @start_time = options['start_time']
  end

  def save()
    sql = "INSERT INTO films (title, price, start_time) VALUES ('#{ @title }',#{ @price }, '#{ @start_time }') RETURNING id"
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    return Film.get_many(sql)
  end

  def self.get_price(title)
    sql = "SELECT price FROM films WHERE title = '#{title}';"
    return SqlRunner.run( sql )[0]['price']
  end

  def self.get_many(sql)
    films = SqlRunner.run(sql)
    films_objects = films.map { |film| Film.new (film)}
    return films_objects
  end

  def self.customers(title)
    sql = "
    SELECT id FROM films WHERE title = '#{title}';
    "
    id = SqlRunner.run( sql )[0]['id']
    sql = "
    SELECT c.name, c.funds FROM customers c
    INNER JOIN tickets t
    ON c.id = t.customer_id 
    WHERE t.film_id =#{id.to_i};
    "
    puts sql
    return Customer.get_many(sql)
  end

  def self.no_of_tickets(title)
    sql = "
    SELECT id FROM films WHERE title = '#{title}';
    "
    id = SqlRunner.run( sql )[0]['id']
    sql = "
    SELECT c.* FROM customers c
    INNER JOIN tickets t
    ON c.id = t.customer_id 
    WHERE t.film_id =#{id};
    "
    ret_arr = Array.new(Customer.get_many(sql))
    return ret_arr.count
  end

  def self.buy_ticket(title, name)
  #First get the price of the film
  sql = "SELECT hall FROM films WHERE title = '#{title}';" 
  hall = SqlRunner.run( sql )[0]['hall']
  #Check if hall is full
  if Hall.check_max(hall) != true
    #There is room so deduct price from funds
    sql = "UPDATE customers SET funds = #{Customer.get_funds(name).to_f - Film.get_price(title).to_f} WHERE name = '#{name}';" 
    SqlRunner.run( sql )
    hall_actual = Hall.get_actual(hall)
    #update the number of customer in the hall
    sql = "UPDATE halls SET actual_customers = #{Hall.get_actual(hall).to_i + 1} WHERE hall = '#{hall}';" 
    SqlRunner.run( sql )
    #Generate the ticket
    ticket = Ticket.new({'customer_id' => Customer.get_customer_id(name), 'film_id' => Film.get_film_id(title), 'hall_id' => Hall.get_hall_id(hall),'purchase_time' => Time.now})
    ticket.save()
  else
    return 'SOLD OUT'
  end
end

def self.get_film_id(title)
  sql = "
  SELECT id FROM films WHERE title = '#{title}';
  "
  return SqlRunner.run( sql )[0]['id']

end
end