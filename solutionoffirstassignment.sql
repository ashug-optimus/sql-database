--Query to create table t_product_master that contains the details of product_id, product_name and cost_per_item

	create table t_product_master
	(
		product_id varchar(5),	
		product_name varchar(20),
		cost_per_item int
	)

--Query to insert data in t_product_master table

	insert into t_product_master 
	values ( 'P1', 'Pen', 10);

	insert into t_product_master 
	values ( 'P2', 'Scale', 15);

	insert into t_product_master 
	values ( 'P3', 'Notebook', 25);

--Query to view the entire data of t_product_master table

	select * from t_product_master

--Query to create t_user_master table that contains the details of user, there name and user_id

	create table t_user_master
	(
		user_id varchar(5),
		user_name varchar(20)
	)

--Query to insert data in t_user_master table

	insert into t_user_master
	values ( 'U1', 'Alfred Lawrence')

	insert into t_user_master
	values ( 'U2', 'William Paul')

	insert into t_user_master
	values ( 'U3', 'Edward Fillip')

--Query to view the entire data of t_user_master table

	select * from t_user_master

--Query to create t_transaction table that contains the information of transaction details

	create table t_transaction
	(
		user_id varchar(5),
		product_id varchar(5),
		transaction_date date,
		transaction_type varchar(20),
		transaction_amount int
	)

--query to insert data in t_transaction table
	insert into t_transaction
	values ( 'U1', 'P1', '2010-10-25', 'Order', 150)

	insert into t_transaction
	values ( 'U1', 'P1', '2010-11-20', 'Payment', 750)

	insert into t_transaction
	values ( 'U1', 'P1', '2010-11-20', 'Order', 200)

	insert into t_transaction
	values ( 'U1', 'P3', '2010-11-25', 'Order', 50)

	insert into t_transaction
	values ( 'U3', 'P2', '2010-11-26', 'Order', 100)

	insert into t_transaction
	values ( 'U2', 'P1', '2010-12-15', 'Order', 75)

	insert into t_transaction
	values ( 'U3', 'P2', '2011-01-15', 'Payment', 250)

--Query to view all the data of t_transaction table

	select * from t_transaction

--query to create table for order_quantity
	create table order_table
	(
		user_name varchar(30),
		product_name varchar(30),
		ordered_quantity int,
		last_transaction_date date
	)

	insert into order_table
		select  t_user_master.user_name,
		        t_product_master.product_name,
		        sum(t_transaction.transaction_amount) as ordered_quantity,
			max(t_transaction.transaction_date)
			from t_transaction join t_user_master on t_transaction.user_id=t_user_master.user_id
			join t_product_master on t_transaction.product_id =t_product_master.product_id 
			where  t_transaction.transaction_type='order'
		        group by t_user_master.user_name,t_product_master.product_name

			  

--query to create table for payment
	create table payment
	(
		user_name varchar(30),
		product_name varchar(30),
		payment int
	)


	insert into payment
		select  t_user_master.user_name,
		        t_product_master.product_name,
		        sum(t_transaction.transaction_amount) as payment
			from t_transaction join t_user_master on t_transaction.user_id=t_user_master.user_id
			join t_product_master on t_transaction.product_id =t_product_master.product_id 
			where  t_transaction.transaction_type='payment'
			group by t_user_master.user_name,t_product_master.product_name

--query to view all the dATA FROM PAYMENT TABLE

	select * from payment

--Query to create table order-payment-info
	create table order_payment_info
	(
		user_name varchar(30),
		product_name varchar(30),
		order_quantity int,
		amount_paid int,
		last_transaction_date date
	)

--Query to insert data in order_payment table
	insert into order_payment_info
		select  order_table.user_name,
		        order_table.product_name,
			order_table.ordered_quantity,
			payment.payment,
			order_table.last_transaction_date
			from order_table left join payment on order_table.user_name=payment.user_name 
			and 
			order_table.product_name=payment.product_name 

--query to view all the dATA FROM order_payment table
	select * from order_payment_info

--Query to find the balance for each user 
	select  A.*,
	        (A.order_quantity*t_product_master.cost_per_item-COALESCE(A.amount_paid,0)) as balance 
		fROM order_payment_info A  
		inner join 
		t_product_master 
		on 
		a.product_name=t_product_master.product_name
