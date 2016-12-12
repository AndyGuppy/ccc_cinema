require ('pry')
require('awesome_print')
require_relative('./models/customer_class')
require_relative('./models/film_class')
require_relative('./models/ticket_class')
require_relative('./models/hall_class')
require_relative('./db/sql_runner')


#Clean up the database by re-running the cinema.sql fle
sql = File.open('db/cinema.sql', 'rb') { |file| file.read }
SqlRunner.with_db do |db|
  begin
    db.exec(sql)
  rescue PG::Error
     #####
   end
 end

# system 'clear'

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


binding.pry
nil
