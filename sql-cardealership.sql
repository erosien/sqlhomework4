create table salesperson(
	salesperson_id SERIAL primary key,
	first_name VARCHAR(150),
	last_name VARCHAR(150)
);

create table customer(
	customer_id SERIAL primary key,
	first_name VARCHAR(150),
	last_name VARCHAR(150),
	address VARCHAR(200)
);

create table cars(
	serial_number SERIAL primary key,
	make VARCHAR(200),
	model VARCHAR(200),
	year_ INTEGER,
	color VARCHAR(200),
	salesperson_id INTEGER not null,
	customer_id INTEGER not null,
	foreign key(salesperson_id) references salesperson(salesperson_id),
	foreign key(customer_id) references customer(customer_id)
);

create table invoice(
	invoice_number SERIAL primary key,
	date_ DATE,
	amount numeric(10,2),
	customer_id INTEGER not null,
	salesperson_id INTEGER not null,
	serial_number INTEGER not null,
	foreign key(customer_id) references customer(customer_id),
	foreign key(salesperson_id) references salesperson(salesperson_id),
	foreign key(serial_number) references cars(serial_number)
);

create table service(
	service_id SERIAL primary key,
	service_type VARCHAR(500)
);

create table mechanic(
	mechanic_id SERIAL primary key,
	first_name VARCHAR(150),
	last_name VARCHAR(150)
);

create table car_parts(
	part_id SERIAL primary key,
	part_name VARCHAR(200),
	stock INTEGER
);

create table service_ticket(
	ticket_number SERIAL primary key,
	date_ DATE,
	amount numeric(10,2),
	service_id INTEGER not null,
	customer_id INTEGER not null,
	serial_number INTEGER not null,
	mechanic_id INTEGER not null,
	part_id INTEGER not null,
	foreign key(service_id) references service(service_id),
	foreign key(customer_id) references customer(customer_id),
	foreign key(serial_number) references cars(serial_number),
	foreign key(mechanic_id) references mechanic(mechanic_id),
	foreign key(part_id) references car_parts(part_id)
);

insert into salesperson(
	salesperson_id,
	first_name,
	last_name
) values (
	1,
	'Harry',
	'Jones'
);

insert into salesperson(
	salesperson_id,
	first_name,
	last_name
) values (
	2,
	'Bridget',
	'Smith'
);

create or replace function add_customer(_customer_id INTEGER, _first_name VARCHAR, _last_name VARCHAR, _address VARCHAR)
returns void
as $MAIN$
begin 
	insert into customer(customer_id,first_name,last_name,address)
	values(_customer_id,_first_name,_last_name,_address);
end;
$MAIN$
language plpgsql;

select add_customer(1, 'Sally', 'Henderson', '123 Sesame Street Houston, TX 12345');
select add_customer(2, 'Ben', 'Wyles', '456 Flower Way Berkeley, CA 67890');
select add_customer(3, 'Jerry', 'Springer', '789 Broadway Wuthering Heights, MA 11122');
select add_customer(4, 'Samson', 'Bruce', '111 New York Avenue, New York, NY 99999');

insert into cars(serial_number,make,model,year_,color,salesperson_id,customer_id)
values(1,'Toyota','Prius',2012,'Blue',1,2);

insert into cars(serial_number,make,model,year_,color,salesperson_id,customer_id)
values(2,'Subaru','Outback',2009,'White',2,1);

insert into cars(serial_number,make,model,year_,color,salesperson_id,customer_id)
values(3,'Toyota','Tacoma',2000,'Red',2,3);

insert into cars(serial_number,make,model,year_,color,salesperson_id,customer_id)
values(4,'Honda','Civic',2020,'Silver',2,4);

insert into invoice(invoice_number,date_,amount,customer_id,salesperson_id,serial_number)
values(1,'10-10-2022','18000',2,1,1);

insert into invoice(invoice_number,date_,amount,customer_id,salesperson_id,serial_number)
values(2,'01-23-2023','12000',1,2,2);

insert into service(service_id,service_type)
values(1,'Oil Change');

insert into service(service_id,service_type)
values(2,'Battery Replacement');

insert into service(service_id,service_type)
values(3,'Tire Rotation');

insert into mechanic(mechanic_id,first_name,last_name)
values(1,'Jimmy','Buffet');

insert into mechanic(mechanic_id,first_name,last_name)
values(2,'Hal','Moore');

insert into car_parts(part_id,part_name,stock)
values(1,'Battery',50);

insert into car_parts(part_id,part_name,stock)
values(2,'Catalytic Converter',10);

insert into car_parts(part_id,part_name,stock)
values(3,'Tires',800);

create or replace function service_ticket(_ticket_number INTEGER, _date_ DATE, _amount numeric, _service_id INTEGER, _customer_id INTEGER, _serial_number INTEGER, _mechanic_id INTEGER, _part_id INTEGER)
returns void
as $MAIN$
begin 
	insert into service_ticket(ticket_number,date_,amount,service_id,customer_id,serial_number,mechanic_id,part_id)
	values(_ticket_number,_date_,_amount,_service_id,_customer_id,_serial_number,_mechanic_id,_part_id);
end;
$MAIN$
language plpgsql;

select service_ticket(1,'02-01-2023','550',2,3,3,1,1);
select service_ticket(2,'02-11-2023','700',3,4,4,2,3);

drop function add_customer;
drop function service_ticket;


