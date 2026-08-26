CREATE TABLE `inventory_transaction_types` (
  `id` TINYINT(4) NOT NULL,
  `type_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`)
);



CREATE TABLE `inventory_transactions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `transaction_type` TINYINT(4) NOT NULL,
  `transaction_created_date` DATETIME DEFAULT NULL,
  `transaction_modified_date` DATETIME DEFAULT NULL,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `purchase_order_id` INT(11) DEFAULT NULL,
  `customer_order_id` INT(11) DEFAULT NULL,
  `comments` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_type` (`transaction_type`),
  KEY `product_id` (`product_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `customer_order_id` (`customer_order_id`),
  CONSTRAINT `fk_inventory_transactions_types`
    FOREIGN KEY (`transaction_type`) REFERENCES `inventory_transaction_types` (`id`),
  CONSTRAINT `fk_inventory_transactions_products`
    FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `fk_inventory_transactions_purchase_orders`
    FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`),
  CONSTRAINT `fk_inventory_transactions_orders`
    FOREIGN KEY (`customer_order_id`) REFERENCES `orders` (`id`)
);