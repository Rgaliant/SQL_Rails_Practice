class Customer < ApplicationRecord
  belongs_to :user

  def self.all_customers(user_id)
    Customer.find_by_sql(
      "SELECT *
      FROM customers AS c
      WHERE c.user_id = #{user_id}"
    )
  end


  def self.single_customer(customer_id)
    Customer.find_by_sql(["
      SELECT * 
      FROM customers AS c
      WHERE c.id = ?
    ", customer_id]).first
  end

  def self.create_customer(p, id)
    Customer.find_by_sql(["
      INSERT INTO customers (first_name, last_name, email, phone, user_id, created_at, updated_at)
      VALUES (:first, :last, :email, :phone, :user_id, :created_at, :updated_at);
    ", {
      first: p[:first_name],
      last: p[:last_name],
      email: p[:email],
      phone: p[:phone],
      user_id: id,
      created_at: DateTime.now,
      updated_at: DateTime.now
    }])
  end

end
