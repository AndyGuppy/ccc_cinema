require ('pry')
require('awesome_print')
require_relative('./models/customer_class')
require_relative('./models/film_class')
require_relative('./models/ticket_class')
require_relative('./models/hall_class')
require_relative('./db/sql_runner')


#Clean up the database by re-running the cinema.sql fle
SqlRunner.reset('db/cinema.sql')


system 'clear'

# #show all halls
# ap Hall.all()
# puts
# #now adding a hall
# hall1 = Hall.new({ 'hall' => 'Back Room', 'max_customers' => 10, 'actual_customers' => 6})
# hall1.save()
# puts
# ap Hall.all()

# puts
# # show all customers

# ap Customer.all()
# # now adding a customer
# puts
# new_customer = Customer.new('name'=> 'Craig', 'funds'=> 100)
# new_customer.save()

# puts
# ap Customer.all()

# # show all films
# puts
# ap Film.all()
# # now adding a film
# puts
# new_film = Film.new('title'=> 'Fame', 'price'=> 7.75,'start_time'=> '9:30pm')
# new_film.save()
# puts
# ap Film.all()

# # show all tickets
# puts
# ap Film.all()
# puts
# new_ticket = Ticket.new('customer_id'=> 2, 'film_id'=> 3,'purchase_time'=> Time.now, 2 )
# new_ticket.save()
# puts
# ap Film.all()

# ap Customer.films('Matthew')

# ap Film.customers('Jaws 99')

puts 'Hall.all() -- lists all halls'
puts 'Hall.get_hall_id(hall name) -- Gets the hall ID from hall name'
puts 'Hall.get_max(hall name) -- gets the maximum customers allowed into hall'
puts 'Hall.get_actual(hall name) -- gets the actual number of customers in the hall'
puts 'Hall.check_max(hall name) -- checks to see if room is full'
puts 'Customer.all() -- lists all customers'
puts 'Customer.films(name) -- returns the films the named customer is going to'
puts 'Customer.get_funds(name) -- get the named persons funds'
puts 'Customer.get_customer_id(name) -- Gets the named customers ID'
puts 'Customer.tickets(name) -- Gets all tickets for a given customer'
puts 'Film.all() -- lists all the films'
puts 'Film.get_price(title) -- gets the price of the film for the given title'
puts 'Film.customers(title) -- gets a list of customers going to the named film, an extension of this could be .count '
puts 'Film.no_of_tickets(title) -- shows the number of tickets sold for given film'
puts 'Film.get_film_id(title) -- returns the ID of the named film'
puts 'Film.buy_ticket(title,name) -- leys yu buy a ticket for the titled film for the named person, will also add person to the hall and deduct price from customers credit'
binding.pry
nil
