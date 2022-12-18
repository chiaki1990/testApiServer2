package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)


type config struct {
	DB db
}

type db struct {
	DBNAME   string
	USER     string
	PASSWORD string
}

func NewConfig() *config {
	db := db{}
	_, err := os.Stat(".env")
	if err == nil {
		err = godotenv.Load()
			if err != nil {
			log.Fatal("Error loading .env file")
		}
	}
	db.DBNAME = os.Getenv("PGDATABASE")
	db.USER = os.Getenv("PGUSER")
	db.PASSWORD = os.Getenv("PGPASSWORD")
	return &config{
		DB: db,
	}
}