DROP DATABASE IF EXISTS `northwind`;
CREATE DATABASE `northwind`;
USE `northwind`;


CREATE TABLE `customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(50) NULL,
  `contact_name` VARCHAR(50) NULL,
  `phone` VARCHAR(25) NULL,
  PRIMARY KEY (`customer_id`)
);


CREATE TABLE `employees` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(50) NULL,
  `first_name` VARCHAR(50) NULL,
  `job_title` VARCHAR(50) NULL,
  PRIMARY KEY (`employee_id`)
);


CREATE TABLE `shippers` (
  `shipper_id` INT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(50) NULL,
  `phone` VARCHAR(25) NULL,
  PRIMARY KEY (`shipper_id`)
);


CREATE TABLE `products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `product_name` VARCHAR(50) NULL,
  `list_price` DECIMAL(19,4) NULL,
  `quantity_per_unit` VARCHAR(50) NULL,
  PRIMARY KEY (`product_id`)
);


CREATE TABLE `suppliers` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(50) NULL,
  `contact_name` VARCHAR(50) NULL,
  `city` VARCHAR(50) NULL,
  PRIMARY KEY (`supplier_id`)
);


CREATE TABLE `privileges` (
  `privilege_id` INT NOT NULL AUTO_INCREMENT,
  `privilege_name` VARCHAR(50) NULL,
  PRIMARY KEY (`privilege_id`)
);


CREATE TABLE `orders_status` (
  `status_id` INT NOT NULL,
  `status_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`status_id`)
);


CREATE TABLE `orders_tax_status` (
  `tax_status_id` INT NOT NULL,
  `tax_status_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`tax_status_id`)
);


CREATE TABLE `order_details_status` (
  `status_id` INT NOT NULL,
  `status_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`status_id`)
);


CREATE TABLE `purchase_order_status` (
  `status_id` INT NOT NULL,
  `status_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`status_id`)
);


CREATE TABLE `inventory_transaction_types` (
  `transaction_type_id` INT NOT NULL,
  `type_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`transaction_type_id`)
);


CREATE TABLE `orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL,
  `employee_id` INT NULL,
  `shipper_id` INT NULL,
  `status_id` INT NULL,
  `tax_status_id` INT NULL,
  `order_date` DATETIME NULL,
  `ship_name` VARCHAR(50) NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_orders_employees`
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_orders_shippers`
    FOREIGN KEY (`shipper_id`) REFERENCES `shippers` (`shipper_id`),
  CONSTRAINT `fk_orders_status`
    FOREIGN KEY (`status_id`) REFERENCES `orders_status` (`status_id`),
  CONSTRAINT `fk_orders_tax_status`
    FOREIGN KEY (`tax_status_id`) REFERENCES `orders_tax_status` (`tax_status_id`)
);


CREATE TABLE `order_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `product_id` INT NULL,
  `status_id` INT NULL,
  `purchase_order_id` INT NULL,
  `quantity` DECIMAL(18,4) NULL,
  `unit_price` DECIMAL(19,4) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_order_details_orders`
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `fk_order_details_products`
    FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `fk_order_details_status`
    FOREIGN KEY (`status_id`) REFERENCES `order_details_status` (`status_id`)
);


CREATE TABLE `invoices` (
  `invoice_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NULL,
  `invoice_date` DATETIME NULL,
  `due_date` DATETIME NULL,
  PRIMARY KEY (`invoice_id`),
  CONSTRAINT `fk_invoices_orders`
    FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
);



CREATE TABLE `purchase_orders` (
  `purchase_order_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NULL,
  `employee_id` INT NULL,
  `status_id` INT NULL,
  `submitted_date` DATETIME NULL,
  PRIMARY KEY (`purchase_order_id`),
  CONSTRAINT `fk_purchase_orders_suppliers`
    FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`),
  CONSTRAINT `fk_purchase_orders_employees`
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_purchase_orders_status`
    FOREIGN KEY (`status_id`) REFERENCES `purchase_order_status` (`status_id`)
);



CREATE TABLE `purchase_order_details` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `purchase_order_id` INT NOT NULL,
  `product_id` INT NULL,
  `quantity` DECIMAL(18,4) NULL,
  `unit_price` DECIMAL(19,4) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_purchase_order_details_orders`
    FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`purchase_order_id`),
  CONSTRAINT `fk_purchase_order_details_products`
    FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
);



CREATE TABLE `inventory_transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `transaction_type` INT NULL,
  `product_id` INT NULL,
  `customer_order_id` INT NULL,
  `purchase_order_id` INT NULL,
  `transaction_created_date` DATETIME NULL,
  `quantity` INT NULL,
  PRIMARY KEY (`transaction_id`),
  CONSTRAINT `fk_inventory_transactions_types`
    FOREIGN KEY (`transaction_type`) REFERENCES `inventory_transaction_types` (`transaction_type_id`),
  CONSTRAINT `fk_inventory_transactions_products`
    FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `fk_inventory_transactions_orders`
    FOREIGN KEY (`customer_order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `fk_inventory_transactions_purchase_orders`
    FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`purchase_order_id`)
);



CREATE TABLE `employee_privileges` (
  `employee_id` INT NOT NULL,
  `privilege_id` INT NOT NULL,
  PRIMARY KEY (`employee_id`, `privilege_id`),
  CONSTRAINT `fk_employee_privileges_employees`
    FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_employee_privileges_privileges`
    FOREIGN KEY (`privilege_id`) REFERENCES `privileges` (`privilege_id`)
);