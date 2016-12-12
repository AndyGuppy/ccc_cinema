DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS halls;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers (
  id SERIAL4 primary key,
  name VARCHAR(255),
  funds REAL
);

CREATE TABLE films (
  id SERIAL4 primary key,
  title VARCHAR(255),
  price REAL,
  start_time VARCHAR(255),
  hall Varchar(255)
);

CREATE TABLE halls (
  id SERIAL4 primary key,
  max_customers INT4 ,
  actual_customers INT4 ,
  hall text
);

CREATE TABLE tickets (
  id SERIAL4 primary key,
  customer_id INT4 references customers(id) ON DELETE CASCADE,
  film_id INT4 references films(id) ON DELETE CASCADE,
  hall_id INT4 references halls(id) ON DELETE CASCADE,
  Purchase_time text
);



-- Some test data

INSERT INTO halls (hall, max_customers, actual_customers) VALUES ('Main',100, 98);
INSERT INTO halls (hall, max_customers, actual_customers) VALUES ('Hall 1',50, 50);
INSERT INTO halls (hall, max_customers, actual_customers) VALUES ('Hall 2',25, 20);


INSERT INTO customers (name, funds) VALUES ('Matthew',100.00);
INSERT INTO customers (name, funds) VALUES ('Beth',100.00);
INSERT INTO customers (name, funds) VALUES ('Rick',100.00);
INSERT INTO customers (name, funds) VALUES ('Simon',100.00);

INSERT INTO films (title, price, start_time, hall) VALUES ('The Nutty Proffessor',9.50,'3:30pm','Main');
INSERT INTO films (title, price, start_time, hall) VALUES ('Jaws 99',6.50,'6:30pm','Main');
INSERT INTO films (title, price, start_time, hall) VALUES ('Jason Bourne',11.50,'5:15pm','Hall 1');
INSERT INTO films (title, price, start_time, hall) VALUES ('Halloween',9.50,'3:30pm', 'Hall 2');

INSERT INTO tickets (customer_id, film_id, purchase_time, hall_id ) VALUES (1,2, timeofday(),1);
INSERT INTO tickets (customer_id, film_id, purchase_time, hall_id ) VALUES (2,4, timeofday(),3);
INSERT INTO tickets (customer_id, film_id, purchase_time, hall_id ) VALUES (1,1, timeofday(),1);
INSERT INTO tickets (customer_id, film_id, purchase_time, hall_id ) VALUES (3,2, timeofday(),2);
INSERT INTO tickets (customer_id, film_id, purchase_time, hall_id ) VALUES (4,2, timeofday(),2);
INSERT INTO tickets (customer_id, film_id, purchase_time, Hall_id ) VALUES (3,1, timeofday(),1);
INSERT INTO tickets (customer_id, film_id, purchase_time, hall_id ) VALUES (4,3, timeofday(),3);

