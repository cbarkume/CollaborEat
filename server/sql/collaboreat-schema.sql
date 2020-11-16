-- MySQL Script generated by MySQL Workbench
-- Mon Nov  9 13:35:38 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema collaboreat-schema
-- -----------------------------------------------------

DROP SCHEMA IF EXISTS `collaboreat-schema` ;

-- -----------------------------------------------------
-- Schema collaboreat-schema
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS `collaboreat-schema` DEFAULT CHARACTER SET utf8 ;
USE `collaboreat-schema` ;

-- -----------------------------------------------------
-- Table `collaboreat-schema`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collaboreat-schema`.`user` (
  `userId` INT NOT NULL auto_increment,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(2048) NOT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `collaboreat-schema`.`role` (
	`roleId` int primary key auto_increment,
    `name` varchar(50) not null unique
);

CREATE TABLE IF NOT EXISTS `collaboreat-schema`.`userRole` (
	`userId` int not null,
    `roleId` int not null,
    constraint pk_userRole
		primary key (userId, roleId),
	constraint fk_userRole_userId
        foreign key (userId)
         references user(userId),
	constraint fk_userRole_roleId
         foreign key (roleId)
         references `role`(roleId)
);


-- -----------------------------------------------------
-- Table `collaboreat-schema`.`mealType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collaboreat-schema`.`mealType` (
  `mealTypeId` INT NOT NULL auto_increment,
  `mealTypeName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`mealTypeId`),
  UNIQUE INDEX `mealTypeName_UNIQUE` (`mealTypeName` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collaboreat-schema`.`recipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collaboreat-schema`.`recipe` (
  `recipeId` INT NOT NULL auto_increment,
  `recipeName` VARCHAR(45) NOT NULL,
  `recipeStory` VARCHAR(2048) NOT NULL,
  `recipeDescription` VARCHAR(1024) NOT NULL,
  `recipeIngredients` VARCHAR(45) NOT NULL,
  `recipeCookTime` INT NOT NULL,
  `recipeSteps` VARCHAR(2048) NOT NULL,
  `recipeDate` DATE NOT NULL,
  `recipeRating` INT NOT NULL,
  `userId` INT NOT NULL,
  `mealTypeId` INT NULL,
  PRIMARY KEY (`recipeId`),
  INDEX `userId_idx` (`userId` ASC) VISIBLE,
  INDEX `mealTypeId_idx` (`mealTypeId` ASC) VISIBLE,
  CONSTRAINT `userId`
    FOREIGN KEY (`userId`)
    REFERENCES `collaboreat-schema`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mealTypeId`
    FOREIGN KEY (`mealTypeId`)
    REFERENCES `collaboreat-schema`.`mealType` (`mealTypeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collaboreat-schema`.`healthInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collaboreat-schema`.`healthInfo` (
  `healthInfoId` INT NOT NULL auto_increment,
  `healthInfoName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`healthInfoId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collaboreat-schema`.`feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collaboreat-schema`.`feedback` (
  `feedbackId` INT NOT NULL auto_increment,
  `feedbackComment` VARCHAR(1024) NOT NULL,
  `feedbackRating` INT NOT NULL,
  `userId` INT NOT NULL,
  `recipeId` INT NOT NULL,
  PRIMARY KEY (`feedbackId`),
  INDEX `recipeId_idx` (`recipeId` ASC) VISIBLE,
  INDEX `userId_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_userId`
    FOREIGN KEY (`userId`)
    REFERENCES `collaboreat-schema`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipeId`
    FOREIGN KEY (`recipeId`)
    REFERENCES `collaboreat-schema`.`recipe` (`recipeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `collaboreat-schema`.`recipeHealthInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `collaboreat-schema`.`recipeHealthInfo` (
  `healthInfoId` INT NOT NULL,
  `recipeId` INT NOT NULL,
  PRIMARY KEY (`healthInfoId`, `recipeId`),
  INDEX `recipeId_idx` (`recipeId` ASC) VISIBLE,
  CONSTRAINT `healthInfoId`
    FOREIGN KEY (`healthInfoId`)
    REFERENCES `collaboreat-schema`.`healthInfo` (`healthInfoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `recipeId`
    FOREIGN KEY (`recipeId`)
    REFERENCES `collaboreat-schema`.`recipe` (`recipeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


insert into `collaboreat-schema`.`user`(`firstName`, `lastName`, `email`, `password`)
		values 
			('Dingo', 'Nevada', 'fakeEmail@fakie.com', 'password'),
            ('Cece', 'Slitty', 'bigFake@fake.com', 'password');
            
insert into role (`name`) 
	values 
		('USER'),
        ('ADMIN');
        
insert into userRole (`userId`, `roleId`)
	values
		(1, 1),
		(2, 2);

insert into `collaboreat-schema`.`mealType`(`mealTypeName`)
		values
			('Breakfast'),
            ('Brunch'),
            ('Desert'),
            ('Dinner'),
            ('Entree'),
            ('Lunch'),
            ('Side'),
            ('Snack');
            
            
            
            
insert into `collaboreat-schema`.`recipe`(`recipeName`, `recipeStory`, `recipeDescription`,`recipeIngredients`,
		`recipeCookTime`, `recipeSteps`, `recipeDate`, `recipeRating`, `userId`, `mealTypeId`)
        values 
			('The Sauce','The Story', 'The Description', 'Milk, Butter, Flour', 15, 'mix the stuff, heat it up', 
				'2020-10-20', 0, 1, 1),
			('The Not Sauce', 'Another Story', 'Another Description', 'Not Milk, Not Butter', 10, 'do nothing, drink alc',
				'2020-10-15', 0, 2, 2);
insert into `collaboreat-schema`.`recipe`(`recipeName`, `recipeStory`, `recipeDescription`,`recipeIngredients`,
		`recipeCookTime`, `recipeSteps`, `recipeDate`, `recipeRating`, `userId`)
        values
			('Yummy Cookies', 'Yet another Story', 'Delicious', 'Milk, Eggs, Flour, Butter', 30, 'mix the stuff, heat it up, enjoy',
				'2020-11-13', 0, 2);
                
insert into `collaboreat-schema`.`healthInfo`(`healthInfoName`)
		values
			('Gluten Free'),
            ('Sugar Free'),
            ('Vegitarian'),
            ('Vegan');
            
insert into `collaboreat-schema`.`feedback`(`feedbackComment`, `feedbackRating`, `userId`, `recipeId`)
		values
			('This is bad', 1, 2, 1),
            ('This is good', 5, 1, 2);
       
insert into `collaboreat-schema`.`recipeHealthInfo`(`healthInfoId`, `recipeId`)
		values
			(2, 1),
            (1, 2);
  
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
