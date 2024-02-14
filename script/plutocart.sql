-- MySQL Script generated by MySQL Workbench
-- Wed Nov 22 22:21:58 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SET time_zone = '+07:00';
SET GLOBAL time_zone = '+07:00';

-- -----------------------------------------------------
-- Schema plutocart
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema plutocart
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `plutocart` DEFAULT CHARACTER SET utf8mb4 ;
USE `plutocart` ;

-- -----------------------------------------------------
-- Table `plutocart`.`account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plutocart`.`account` (
  `id_account` INT NOT NULL AUTO_INCREMENT,
  `imei` VARCHAR(200) NOT NULL,
  `email` VARCHAR(50) NULL,
  `account_role` ENUM('Guest', 'Member') NOT NULL,
  PRIMARY KEY (`id_account`),
  UNIQUE INDEX `email_google_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plutocart`.`wallet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plutocart`.`wallet` (
  `id_wallet` INT NOT NULL AUTO_INCREMENT,
  `name_wallet` VARCHAR(45) NOT NULL,
  `balance_wallet` DECIMAL(13,2) NOT NULL DEFAULT 1.00,
  `status_wallet` TINYINT NOT NULL DEFAULT 1,
  `account_id_account` INT NOT NULL,
  `create_wallet_on` DATETIME NOT NULL,
  `update_wallet_on` DATETIME NOT NULL,
  PRIMARY KEY (`id_wallet`),
  INDEX `fk_wallet_account1_idx` (`account_id_account` ASC) VISIBLE,
  CONSTRAINT `fk_wallet_account1`
    FOREIGN KEY (`account_id_account`)
    REFERENCES `plutocart`.`account` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plutocart`.`goal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plutocart`.`goal` (
  `id_goal` INT NOT NULL AUTO_INCREMENT,
  `name_goal` VARCHAR(45) NOT NULL,
  `amount_goal` DECIMAL(13,2) NOT NULL,
  `deficit` DECIMAL(13,2) NOT NULL DEFAULT 0.00,
  `end_date_goal` DATETIME NOT NULL,
  `status_goal` ENUM('1','2','3') NOT NULL DEFAULT 1,
  `account_id_account` INT NOT NULL,
  `create_goal_on` DATETIME NOT NULL,
  `update_goal_on` DATETIME NOT NULL,
  PRIMARY KEY (`id_goal`),
  INDEX `fk_goal_account1_idx` (`account_id_account` ASC) VISIBLE,
  CONSTRAINT `fk_goal_account1`
    FOREIGN KEY (`account_id_account`)
    REFERENCES `plutocart`.`account` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plutocart`.`transaction_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plutocart`.`transaction_category` (
  `id_transaction_category` INT NOT NULL AUTO_INCREMENT,
  `name_transaction_category` VARCHAR(45) NOT NULL,
  `type_category` ENUM('income', 'expense', 'goal', 'debt') NOT NULL,
  `image_icon_url` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id_transaction_category`),
  UNIQUE INDEX `name_transaction_category_UNIQUE` (`name_transaction_category` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plutocart`.`debt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plutocart`.`debt` (
  `id_debt` INT NOT NULL AUTO_INCREMENT,
  `name_debt` VARCHAR(45) NOT NULL,
  `amount_debt` DECIMAL(13,2) NOT NULL DEFAULT 0.00,
  `pay_period` INT NOT NULL DEFAULT 1,
  `num_of_paid_period` INT NOT NULL DEFAULT 0,
  `paid_debt_per_period`INT NOT NULL,
  `total_paid_debt` DECIMAL(13,2) NOT NULL DEFAULT 0.00,
  `money_lender` VARCHAR(15) NOT NULL,
  `status_debt` ENUM('1','2','3') NOT NULL DEFAULT 1,
  `latest_pay_date` DATETIME DEFAULT NULL,
  `create_debt_on` DATETIME NOT NULL,
  `update_debt_on` DATETIME NOT NULL,
  `account_id_account` INT NOT NULL,
  PRIMARY KEY (`id_debt`),
  INDEX `fk_debt_account1_idx` (`account_id_account` ASC) VISIBLE,
  CONSTRAINT `fk_debt_account1`
    FOREIGN KEY (`account_id_account`)
    REFERENCES `plutocart`.`account` (`id_account`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `plutocart`.`transaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `plutocart`.`transaction` (
  `id_transaction` INT NOT NULL AUTO_INCREMENT,
  `stm_transaction` DECIMAL(13,2) NOT NULL DEFAULT 0.00,
  `statement_type` ENUM('income', 'expense') NOT NULL,
  `date_transaction` DATETIME NOT NULL,
  `tran_category_id_category` INT NOT NULL,
  `description` VARCHAR(100) NULL DEFAULT NULL,
  `image_url` VARCHAR(200) NULL DEFAULT NULL,
  `debt_id_debt` INT NULL,
  `goal_id_goal` INT NULL,
  `create_transaction_on` DATETIME NOT NULL,
  `update_transaction_on` DATETIME NOT NULL,
  `wallet_id_wallet` INT NOT NULL,
  PRIMARY KEY (`id_transaction`),
  INDEX `fk_transaction_debt1_idx` (`debt_id_debt` ASC) VISIBLE,
  INDEX `fk_transaction_category1_idx` (`tran_category_id_category` ASC) VISIBLE,
  INDEX `fk_transaction_goal1_idx` (`goal_id_goal` ASC) VISIBLE,
  INDEX `fk_transaction_wallet1_idx` (`wallet_id_wallet` ASC) VISIBLE,
  CONSTRAINT `fk_transaction_debt1`
    FOREIGN KEY (`debt_id_debt`)
    REFERENCES `plutocart`.`debt` (`id_debt`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_category1`
    FOREIGN KEY (`tran_category_id_category`)
    REFERENCES `plutocart`.`transaction_category` (`id_transaction_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_goal1`
    FOREIGN KEY (`goal_id_goal`)
    REFERENCES `plutocart`.`goal` (`id_goal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transaction_wallet1`
    FOREIGN KEY (`wallet_id_wallet`)
    REFERENCES `plutocart`.`wallet` (`id_wallet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into account (id_account  , imei , email  , account_role) values(1 , 'admin_imei' , 'admin@gmail.com'  , 2);

insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(1 , 'Salary' , 1 , 'https://res.cloudinary.com/dtczkwnwt/image/upload/v1700856731/category_images/Icon-%E0%B9%80%E0%B8%87%E0%B8%B4%E0%B8%99%E0%B9%80%E0%B8%94%E0%B8%B7%E0%B8%AD%E0%B8%99.png'); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(2 , 'Pocket money' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700856997/category_images/Icon-%E0%B8%84%E0%B9%88%E0%B8%B2%E0%B8%82%E0%B8%99%E0%B8%A1.png");
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(3 , 'Davidend' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700856978/category_images/Icon-%E0%B8%A5%E0%B8%87%E0%B8%97%E0%B8%B8%E0%B8%99.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(4 , 'Allowance' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857421/category_images/Icon-Allowance.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(5 , 'Pension' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857447/category_images/Icon-Pension.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(6 , 'Reward' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857460/category_images/Icon-Reward.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(7 , 'Bonus' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857474/category_images/Icon-Bonus.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(8 , 'Collect rent' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857502/category_images/Icon-Collect_rent.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(9 , 'Win the lottery' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857526/category_images/Icon-Win_Lottery.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(10 , 'Freelance' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857547/category_images/Icon-Part_time.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(11 , 'Part-time' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857564/category_images/Icon-Freelance.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(12, 'Sell Things' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857574/category_images/Icon-Sell_things.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(13, 'Red envelope' , 1 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857581/category_images/Icon-%E0%B8%AD%E0%B8%B1%E0%B9%88%E0%B8%87%E0%B9%80%E0%B8%9B%E0%B8%B2.png"); 

insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(14 , 'Food' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857873/category_images/Icon-eat.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(15, 'Gasoline' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857881/category_images/Icon-Gasoline.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(16, 'Telephone bill' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857895/category_images/Icon-Telephone%20bill.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(17, 'Medical' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857943/category_images/Icon-Medical.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(18, 'Shopping' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857954/category_images/Icon-Shopping.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(19, 'Electricity bill' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857970/category_images/Icon-Electric.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(20, 'Water bill' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857986/category_images/Icon-water.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(21, 'Home installment' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700857998/category_images/Icon-home.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(22, 'Travel' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700858007/category_images/Icon-Travel.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(23, 'Fare' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700858038/category_images/Icon-fare.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(24, 'Drinking' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700858050/category_images/Icon-Drink.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(25, 'Donate' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700858062/category_images/Icon-Donate.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(26, 'Household items' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700858086/category_images/Icon-Home_items.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(27, 'Pay for rent' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700858104/category_images/Icon-Rent.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(28, 'Transfer money' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700858112/category_images/Icon-Transfer_money.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(29, 'Lottery' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1700930017/test/Icon-Lottery.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(30, 'Home Internet' , 2 , "https://res.cloudinary.com/dtczkwnwt/image/upload/v1704136130/category_images/Icon-Home-internet_f3529089-88e2-481b-9d0a-394e62c2ce3a.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(31, 'Education' , 2 ,"https://res.cloudinary.com/dtczkwnwt/image/upload/v1704136306/category_images/Icon-Education_75061b18-9f27-48a6-9cd9-22d249638bef.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(32, 'Goals' , 2 ,"https://res.cloudinary.com/dtczkwnwt/image/upload/v1706441684/category_images/Goals_76349a46-07b8-4024-97f5-9eb118aa533d.png"); 
insert into transaction_category (id_transaction_category , name_transaction_category , type_category , image_icon_url) values(33, 'Debts' , 2 ,"https://res.cloudinary.com/dtczkwnwt/image/upload/v1706441750/category_images/Debts_89cb0a76-a6c2-49c6-8ff3-e4a70555330d.png");
 
insert into wallet (id_wallet , name_wallet , balance_wallet , status_wallet , account_id_account , create_wallet_on , update_wallet_on) values(1 , 'admin wallet' , 100000.00 , default , 1 , now() , now());
insert into wallet (id_wallet , name_wallet , balance_wallet , status_wallet , account_id_account , create_wallet_on , update_wallet_on) values(2 , 'admin wallet' , 999999.00 , default , 1 , now() , now());
insert into wallet (id_wallet , name_wallet , balance_wallet , status_wallet , account_id_account , create_wallet_on , update_wallet_on) values(3 , 'admin 🥲🐇' , 1111111.00 , default , 1 , now() , now());

DELIMITER //

CREATE PROCEDURE InsertIntoWallet( in walletName varchar(15) , in balanceWallet decimal(13 ,2) ,  in accountId int)
BEGIN
    DECLARE account_count INT;
    SELECT COUNT(*) into account_count  FROM wallet WHERE account_id_account = accountId;
    IF account_count <6 THEN
        INSERT INTO wallet ( name_wallet, balance_wallet, status_wallet, account_id_account, create_wallet_on, update_wallet_on)
        VALUES ( walletName, balanceWallet, default, accountId, NOW(), NOW());
	 ELSE
        SELECT 'Maximum wallet limit reached for this account.' AS status;
    END IF;
    
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE deleteWalletBYWalletId( in accountId int , in walletId int)
BEGIN
   -- DELETE FROM transaction WHERE wallet_id_wallet = walletId;
	DELETE FROM wallet where id_wallet = walletId and account_id_account = accountId;
END //
DELIMITER ;

-- view transaction by account id 
DELIMITER //
CREATE PROCEDURE viewTransactionByAccountId(in accountId int)
BEGIN
	select t.* from transaction t join wallet w on
    t.wallet_id_wallet = w.id_wallet where w.account_id_account = accountId;
END //
DELIMITER ;

-- view transaction by account id & wallet id
DELIMITER //
CREATE PROCEDURE viewTransactionByAccountIdAndWalletId(
	in accountId int,
	in walletId int  )
BEGIN
	select t.* from transaction t join wallet w on
    t.wallet_id_wallet = w.id_wallet where t.wallet_id_wallet = walletId and w.account_id_account = accountId;
END //
DELIMITER ;

-- view transaction by account id & wallet id & transaction id
DELIMITER //
CREATE PROCEDURE viewTransactionByAccountIdAndWalletIdAndTransactionId(
	in accountId int,
	in walletId int,
    in transactionId int)
BEGIN
	select t.* from transaction t join wallet w on
    t.wallet_id_wallet = w.id_wallet where t.id_transaction = transactionId and t.wallet_id_wallet = walletId and w.account_id_account = accountId;
END //
DELIMITER ;

-- create transaction 
DELIMITER //
CREATE PROCEDURE InsertIntoTransactionByWalletId(
    IN walletId INT,
    IN stmTransaction DECIMAL(10, 2),
    IN statementType INT,
    IN dateTransaction DATETIME,
    IN tranCategoryIdCategory INT,
    IN descriptionOfT varchar(100),
    IN imageUrl varchar(200),
	IN debtIdDebt INT,
    IN goalIdGoal INT
)
BEGIN
    DECLARE createTransactionOn DATETIME;
    DECLARE updateTransactionOn DATETIME;
    DECLARE balanceAdjustment DECIMAL(10, 2);

    SET createTransactionOn = NOW();
    SET updateTransactionOn = NOW();

    -- Determine the balance adjustment based on the statement type
    IF statementType = 1 THEN
        SET balanceAdjustment = stmTransaction;  -- Income
    ELSEIF statementType = 2 THEN
        SET balanceAdjustment = -stmTransaction; -- Expense
    ELSE
        -- Handle other statement types if needed
        SET balanceAdjustment = 0;
    END IF;

    -- Insert into the transaction table
    INSERT INTO transaction (
        stm_transaction,
        statement_type,
        date_transaction,
        tran_category_id_category,
        description,
        image_url,
        debt_id_debt,
        goal_id_goal,
        create_transaction_on,
        update_transaction_on,
        wallet_id_wallet
    ) VALUES (
        stmTransaction,
        statementType,
        dateTransaction,
        tranCategoryIdCategory,
        descriptionOfT,
        imageUrl,
        debtIdDebt,
        goalIdGoal,
        createTransactionOn,
        updateTransactionOn,
        walletId
    );

    -- Update the balance_wallet in the wallet table
    UPDATE wallet
    SET balance_wallet = balance_wallet + balanceAdjustment
    WHERE id_wallet = walletId;
    
    -- goal check goal or debt id if it have update deficit + balanceAdjustment
    IF goalIdGoal IS NOT NULL THEN
        UPDATE goal
		SET deficit = deficit + stmTransaction
		WHERE id_goal = goalIdGoal;
        
        	UPDATE goal
		SET status_goal = 1
		WHERE id_goal = goalIdGoal AND deficit < amount_goal;
    
		UPDATE goal
		SET status_goal = 2
		WHERE id_goal = goalIdGoal AND deficit >= amount_goal;
	END IF;
    
    IF debtIdDebt IS NOT NULL THEN
        UPDATE debt
		SET total_paid_debt = total_paid_debt + stmTransaction,
			num_of_paid_period = num_of_paid_period + 1,
            latest_pay_date = createTransactionOn
		WHERE id_debt = debtIdDebt;
        
		UPDATE debt
		SET status_debt = 1
		WHERE id_debt = debtIdDebt AND total_paid_debt < amount_debt;
    
		UPDATE debt
		SET status_debt = 2
		WHERE id_debt = debtIdDebt AND total_paid_debt >= amount_debt;
	END IF;
    
END //
DELIMITER ;

-- delete transaction
DELIMITER //
CREATE PROCEDURE DeleteTransactionByTransactionId(
    IN transactionId INT,
    IN stmTransaction DECIMAL(10, 2),
    IN stmType VARCHAR(10),
    IN walletId INT,
    IN goalIdGoal INT,
    IN debtIdDebt INT
)
BEGIN
    DECLARE balanceAdjustment DECIMAL(10, 2);

    -- Delete the transaction by transactionId
    DELETE FROM transaction WHERE id_transaction = transactionId;

    -- Determine the balance adjustment based on the statement type
    IF stmType = 'income' THEN
        SET balanceAdjustment = -stmTransaction;  -- Invert for income
    ELSEIF stmType = 'expense' THEN
        SET balanceAdjustment = stmTransaction;   -- Keep as is for expense
    ELSE
        -- Handle other statement types if needed
        SET balanceAdjustment = 0;
    END IF;

    -- Update the balance_wallet in the wallet table
    UPDATE wallet
    SET balance_wallet = balance_wallet + balanceAdjustment
    WHERE id_wallet = walletId;
    
	IF goalIdGoal IS NOT NULL THEN
        UPDATE goal
		SET deficit = deficit - stmTransaction
		WHERE id_goal = goalIdGoal;
        
		UPDATE goal
		SET status_goal = 1
		WHERE id_goal = goalIdGoal AND deficit < amount_goal;
    
		UPDATE goal
		SET status_goal = 2
		WHERE id_goal = goalIdGoal AND deficit >= amount_goal;
	END IF;
    
	IF debtIdDebt IS NOT NULL THEN
        UPDATE debt
		SET total_paid_debt = total_paid_debt - stmTransaction,
			num_of_paid_period = num_of_paid_period - 1
--             latest_pay_date = dateTransaction
		WHERE id_debt = debtIdDebt;
        
		UPDATE debt
		SET status_debt = 1
		WHERE id_debt = debtIdDebt AND total_paid_debt < amount_debt;
    
		UPDATE debt
		SET status_debt = 2
		WHERE id_debt = debtIdDebt AND total_paid_debt >= amount_debt;
	END IF;
    
END //
DELIMITER ;

-- update transaction
DELIMITER //
CREATE PROCEDURE UpdateTransaction(
    IN walletId INT,
    IN transactionId INT,
    IN stmTransaction DECIMAL(10, 2),
    IN statementType INT,
    IN dateTransaction DATETIME,
	IN tranCategoryIdCategory INT,
    IN description VARCHAR(100),
    IN imageUrl VARCHAR(200),
    IN debtIdDebt INT,
    IN goalIdGoal INT
)
BEGIN
    DECLARE oldStmTransaction DECIMAL(10, 2);
    DECLARE currentBalance DECIMAL(10, 2);
    DECLARE newBalance DECIMAL(10, 2);
    DECLARE stmType INT;
    DECLARE updateTransactionOn DATETIME;
    
    SET updateTransactionOn = NOW();

    -- Get the old stmTransaction value and statementType
    SELECT stm_transaction, statement_type INTO oldStmTransaction, stmType
    FROM transaction
    WHERE id_transaction = transactionId;

    -- Get the current balance
    SELECT balance_wallet INTO currentBalance
    FROM wallet
    WHERE id_wallet = walletId;

    -- Update the wallet table based on statementType
    IF stmType = 1 THEN
        -- Subtract the old stmTransaction for statementType = 1
        UPDATE wallet
        SET balance_wallet = balance_wallet - oldStmTransaction
        WHERE id_wallet = walletId;
    ELSEIF stmType = 2 THEN
        -- Add the old stmTransaction for statementType = 2
        UPDATE wallet
        SET balance_wallet = balance_wallet + oldStmTransaction
        WHERE id_wallet = walletId;
    END IF;
    
	IF goalIdGoal IS NOT NULL THEN
        UPDATE goal
		SET deficit = deficit - oldStmTransaction
		WHERE id_goal = goalIdGoal;
	END IF;
    
	IF debtIdDebt IS NOT NULL THEN
        UPDATE debt
		SET total_paid_debt = total_paid_debt - oldStmTransaction
		WHERE id_debt = debtIdDebt;
	END IF;
    
    -- Update the transaction table
    UPDATE transaction
    SET
        stm_transaction = stmTransaction,
        statement_type = statementType,
        date_transaction = dateTransaction,
        tran_category_id_category = tranCategoryIdCategory,
        description = description,
        image_url = imageUrl,
        debt_id_debt = debtIdDebt,
        goal_id_goal = goalIdGoal,
        update_transaction_on = updateTransactionOn
    WHERE id_transaction = transactionId;

    -- Calculate new balance based on statementType
    IF statementType = 1 THEN
        SET newBalance = stmTransaction;
    ELSEIF statementType = 2 THEN
        SET newBalance = -stmTransaction;
    END IF;

    -- Update the wallet table with the new balance
    UPDATE wallet
    SET balance_wallet = balance_wallet + newBalance
    WHERE id_wallet = walletId;
    
	IF goalIdGoal IS NOT NULL THEN
        UPDATE goal
		SET deficit = deficit + stmTransaction
		WHERE id_goal = goalIdGoal;
        
		UPDATE goal
		SET status_goal = 1
		WHERE id_goal = goalIdGoal AND deficit < amount_goal;
        
		UPDATE goal
		SET status_goal = 2
		WHERE id_goal = goalIdGoal AND deficit >= amount_goal;
	END IF;
    
	IF debtIdDebt IS NOT NULL THEN
        UPDATE debt
		SET total_paid_debt = total_paid_debt + stmTransaction,
			latest_pay_date = updateTransactionOn
		WHERE id_debt = debtIdDebt;
        
		UPDATE debt
		SET status_debt = 1
		WHERE id_debt = debtIdDebt AND total_paid_debt < amount_debt;
    
		UPDATE debt
		SET status_debt = 2
		WHERE id_debt = debtIdDebt AND total_paid_debt >= amount_debt;
	END IF;
    
END //
DELIMITER ;

-- view latested 3 transaction
DELIMITER //
CREATE PROCEDURE viewTransactionByAccountIdLimitThree(in accountId int)
BEGIN
	SELECT t.*
FROM transaction t
JOIN wallet w ON t.wallet_id_wallet = w.id_wallet
WHERE w.account_id_account = accountId
ORDER BY t.create_transaction_on DESC
LIMIT 3;
END //
DELIMITER ;

-- view today income
DELIMITER //

CREATE PROCEDURE viewTodayIncome(
    IN accountId INT, 
    IN walletId INT, 
    OUT todayIncome DECIMAL(10, 2)
)
BEGIN
    DECLARE today DATE;
    SET today = CURDATE();

    SELECT IFNULL(SUM(t.stm_transaction), 0) INTO todayIncome
    FROM transaction t
    JOIN wallet w ON t.wallet_id_wallet = w.id_wallet
    WHERE w.account_id_account = accountId
        AND w.id_wallet = walletId
        AND DATE(t.date_transaction) = today
        AND t.statement_type = 1; -- Assuming 1 is the code for 'income';
END //

DELIMITER ;

-- view today expense
DELIMITER //

CREATE PROCEDURE viewTodayExpense(
    IN accountId INT, 
    IN walletId INT, 
    OUT todayExpense DECIMAL(10, 2)
)
BEGIN
    DECLARE today DATE;
    SET today = CURDATE();

    SELECT IFNULL(SUM(t.stm_transaction), 0) INTO todayExpense
    FROM transaction t
    JOIN wallet w ON t.wallet_id_wallet = w.id_wallet
    WHERE w.account_id_account = accountId
        AND w.id_wallet = walletId
        AND DATE(t.date_transaction) = today
        AND t.statement_type = 2; -- Assuming 2 is the code for 'expense';
END //

DELIMITER ;

-- view today income and expense
DELIMITER //

CREATE PROCEDURE viewTodayIncomeAndExpense(
    IN accountId INT, 
    IN walletId INT, 
    OUT todayIncome DECIMAL(10, 2), 
    OUT todayExpense DECIMAL(10, 2)
)
BEGIN
    -- Call viewTodayIncome procedure and store the result in OUT parameter
    CALL viewTodayIncome(accountId, walletId, todayIncome);

    -- Call viewTodayExpense procedure and store the result in OUT parameter
    CALL viewTodayExpense(accountId, walletId, todayExpense);
END //

DELIMITER ;

-- account  
-- create account guest by use imei
DELIMITER //

CREATE  PROCEDURE `createAccountByImei`(IN InImei VARCHAR(200))
BEGIN
    DECLARE countAccounts INT;

    SELECT COUNT(*) INTO countAccounts FROM account WHERE imei = InImei AND account_role = 1;

    IF countAccounts >= 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'account not register becuase account same imei and account role';
    ELSE
        INSERT INTO account (imei, email, account_role)
        VALUES ( InImei, null, DEFAULT);
    END IF;
    SET countAccounts = 0;
END //
DELIMITER ;

-- create account member by Google account
DELIMITER //
CREATE  PROCEDURE `createAccountByGoogle`( IN InImei VARCHAR(200) , in InEmail VARCHAR(50))
BEGIN
    DECLARE countAccounts INT;

    SELECT COUNT(*) INTO countAccounts FROM account WHERE email = InEmail AND account_role = 2;

    IF countAccounts >= 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'account not register becuase account same imei and account role';
    ELSE
        INSERT INTO account (imei, email, account_role)
        VALUES (InImei, InEmail, 2);
    END IF;
    SET countAccounts = 0;
END //
DELIMITER ;

-- view goal
DELIMITER //
CREATE PROCEDURE `viewGoalByAccountId`( 
    IN InAccountId INT 
)
BEGIN
    DECLARE currentDate DATE;
    SET currentDate = CURDATE();

    UPDATE goal
    SET status_goal = 3
    WHERE account_id_account = InAccountId 
    AND status_goal != 2
    AND end_date_goal < currentDate;

    SELECT * FROM goal WHERE account_id_account = InAccountId;
END //
DELIMITER ;

-- create goal
DELIMITER //
CREATE PROCEDURE `createGoalByAccountId`(
    IN InNameGoal VARCHAR(45),
    IN InAmountGoal DECIMAL(13,2),
    IN InDeficit DECIMAL(13,2),
    IN InEndDateGoal DATETIME,
    IN InAccountId INT
)
BEGIN
    DECLARE new_goal_id INT;

    -- Step 1: Insert new goal
    INSERT INTO `plutocart`.`goal` (`name_goal`, `amount_goal`, `deficit`, `end_date_goal`, `account_id_account`, `create_goal_on`, `update_goal_on`)
    VALUES (InNameGoal, InAmountGoal, InDeficit, InEndDateGoal, InAccountId, NOW(), NOW());

    -- Step 2: Get the ID of the newly inserted goal
    SET new_goal_id = LAST_INSERT_ID();

    -- Step 3: Update the status_goal based on the condition
    UPDATE `plutocart`.`goal`
    SET `status_goal` = 2
    WHERE `id_goal` = new_goal_id AND `deficit` >= `amount_goal`;

END //

DELIMITER ;

-- update goal
DELIMITER //
CREATE  PROCEDURE `updateGoalByGoalId`( 
in InNameGoal VARCHAR(15) ,
in InAmountGoal  decimal(10 , 2) ,
in InDeficit decimal(10,2)  ,
in InEndDateGoal dateTime ,
in InGoalId int
-- in amountOfTransaction decimal(10,2) 
)
BEGIN

 UPDATE goal
		SET 
			name_goal = InNameGoal,
			amount_goal = InAmountGoal,
--             deficit = InDeficit + amountOfTransaction,
            deficit = InDeficit,
            end_date_goal = InEndDateGoal,
            update_goal_on = now()
		WHERE id_goal = InGoalId;
        
	UPDATE goal
    SET status_goal = 1
    WHERE id_goal = InGoalId AND deficit < amount_goal;
    UPDATE goal
    SET status_goal = 2
    WHERE id_goal = InGoalId AND deficit >= amount_goal;
        
END //
DELIMITER ;

-- update goal to complete 
DELIMITER //
CREATE  PROCEDURE `updateGoalToComplete`( 
in InAccountId int,
in InGoalId int
)
BEGIN

 UPDATE goal
		SET status_goal = 2
		WHERE id_goal = InGoalId AND account_id_account = InAccountId;
        
END //
DELIMITER ;

-- create debt
DELIMITER //
CREATE PROCEDURE createDebtByAccountId(
    IN InNameDebt VARCHAR(45),
    IN InAmountDebt DECIMAL(13,2),
    IN InPayPeriod INT,
    IN InNumOfPaidPeriod INT,
    IN InPaidDebtPerPeriod DECIMAL(13,2),
    IN InTotalPaidDebt DECIMAL(13,2),
    IN InMoneyLender VARCHAR(15),
    IN InLatestPayDate DATETIME,
    IN InAccountId INT
)
BEGIN
    DECLARE new_debt_id INT;

    -- Step 1: Insert new debt
    INSERT INTO plutocart.debt (name_debt, amount_debt, pay_period, num_of_paid_period, paid_debt_per_period, total_paid_debt, money_lender, latest_pay_date, create_debt_on, update_debt_on,account_id_account)
    VALUES (InNameDebt, InAmountDebt, InPayPeriod, InNumOfPaidPeriod, InPaidDebtPerPeriod, InTotalPaidDebt, InMoneyLender, InLatestPayDate, NOW(), NOW(), InAccountId);

    -- Step 2: Get the ID of the newly inserted goal
    SET new_debt_id = LAST_INSERT_ID();

    -- Step 3: Update the status_goal based on the condition
    UPDATE debt
    SET status_debt = 2
    WHERE id_debt = new_debt_id AND total_paid_debt >= amount_debt;

END //

DELIMITER ;

-- update debt
DELIMITER //
CREATE PROCEDURE updateDebtByAccountId(
    IN InNameDebt VARCHAR(45),
    IN InAmountDebt DECIMAL(13,2),
    IN InPayPeriod INT,
    IN InNumOfPaidPeriod INT,
    IN InPaidDebtPerPeriod DECIMAL(13,2),
    IN InTotalPaidDebt DECIMAL(13,2),
    IN InMoneyLender VARCHAR(15),
    IN InLatestPayDate DATETIME,
    IN InDebtId INT
)
BEGIN
	
    UPDATE debt
    SET name_debt = InNameDebt,
		amount_debt = InAmountDebt,
        pay_period = InPayPeriod,
        num_of_paid_period = InNumOfPaidPeriod,
        paid_debt_per_period = InPaidDebtPerPeriod,
        total_paid_debt = InTotalPaidDebt,
        money_lender = InMoneyLender,
        latest_pay_date = InLatestPayDate
    WHERE id_debt = InDebtId;
    
    UPDATE debt
    SET status_debt = 1
    WHERE id_debt = InDebtId AND total_paid_debt < amount_debt;
    
    UPDATE debt
    SET status_debt = 2
    WHERE id_debt = InDebtId AND total_paid_debt >= amount_debt;

END //

DELIMITER ;

-- update account from guest to member
DELIMITER //
CREATE  PROCEDURE `updateAccountToMember`( IN InEmail VARCHAR(50) , in InAccountId int)
BEGIN
    DECLARE countAccounts INT;

    SELECT COUNT(*) INTO countAccounts FROM account WHERE email = InEmail AND account_role = 2;

    IF countAccounts >= 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'account not update to account member becuase email has register';
    ELSE
       update account  set email = inEmail , account_role = 2  where id_account = InAccountId and account_role != 2;
    END IF;
    SET countAccounts = 0;
END //
DELIMITER ;

-- delete account  
DELIMITER //
CREATE PROCEDURE `deleteAccount`(IN InAccountId INT)
BEGIN
  SET @wallet_ids = (SELECT GROUP_CONCAT(id_wallet) FROM wallet WHERE account_id_account = InAccountId);
  
  WHILE LENGTH(@wallet_ids) > 0 DO
    SET @wallet_id = SUBSTRING_INDEX(@wallet_ids, ',', 1);
    CALL deleteWalletBYWalletId(InAccountId, @wallet_id);
    SET @wallet_ids = TRIM(BOTH ',' FROM SUBSTRING(@wallet_ids, LENGTH(@wallet_id) + 2));
  END WHILE;
  delete from account where id_account = InAccountId;
END //
DELIMITER ;