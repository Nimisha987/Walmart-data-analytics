CREATE TABLE IF NOT EXISTS walmart (
    invoice_id VARCHAR(50),
    branch VARCHAR(10),
    city VARCHAR(50),
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    quantity INT,
    date DATE,
    time TIME,
    payment_method VARCHAR(20),
    rating DECIMAL(3,1),
    total DECIMAL(10,2),
    profit_margin DECIMAL(5,2)
);
