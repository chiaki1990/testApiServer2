package database

import (
	"database/sql"
	"fmt"
	"go-sample/config"

	_ "github.com/lib/pq"
	"github.com/volatiletech/sqlboiler/boil"
)

var Repository boil.ContextExecutor

func ConnectDB() {
	config := config.NewConfig()
	fmt.Println(config.DB.USER, config.DB.PASSWORD, config.DB.DBNAME)
	db, err := sql.Open("postgres", fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable", config.DB.USER, config.DB.PASSWORD, config.DB.DBNAME))
	if err != nil {
		panic(err)
	}
	boil.SetDB(db)
	Repository = db
}
