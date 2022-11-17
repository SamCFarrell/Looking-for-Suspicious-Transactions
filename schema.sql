DROP TABLE IF EXISTS card_holder;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS merchant;
DROP TABLE IF EXISTS merchant_category;
DROP TABLE IF EXISTS transaction;

CREATE TABLE "card_holder" (
	"id" INT NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	CONSTRAINT "pk_cardholder" PRIMARY KEY (
		"id"
	)
);

CREATE TABLE "credit_card" (
	"card" VARCHAR(20) NOT NULL,
	"cardholder_id" INT NOT NULL,
	CONSTRAINT "pk_creditcard" PRIMARY KEY (
		"card"
	)
);

CREATE TABLE "merchant_category" (
	"id" INT NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	CONSTRAINT "pk_merchcategory" PRIMARY KEY (
		"id"
	)
);

CREATE TABLE "merchant" (
	"id" INT NOT NULL,
	"name" VARCHAR(255) NOT NULL,
	"id_merchant_category" INT NOT NULL,
	CONSTRAINT "pk_merchant" PRIMARY KEY (
		"id"
	)
);

CREATE TABLE "transaction" (
	"id" INT NOT NULL,
	"date" TIMESTAMP NOT NULL,
	"amount" FLOAT NOT NULL,
	"card" VARCHAR(20) NOT NULL,
	"id_merchant" INT NOT NULL,
	CONSTRAINT "pk_transaction" PRIMARY KEY (
		"id"
	)
);

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_merchant" FOREIGN KEY("id_merchant")
REFERENCES "merchant" ("id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_mc" FOREIGN KEY("id_merchant_category")
REFERENCES "merchant_category" ("id");


ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_cc" FOREIGN KEY("card")
REFERENCES "credit_card" ("card");

ALTER TABLE "credit_card" ADD CONSTRAINT "fk_cc_ch" FOREIGN KEY("cardholder_id")
REFERENCES "card_holder" ("id");