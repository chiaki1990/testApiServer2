package main

import (
	"context"
	"log"
	"net/http"

	"go-sample/database"

	"go-sample/app/db"

	"github.com/gin-gonic/gin"
)

func main() {
	log.Println("start server...")
	database.ConnectDB()
	r := gin.Default()
	r.GET("/hello", func(context *gin.Context) {
		context.JSON(200, gin.H{
			"message": "Hello World!",
		})
	})
	r.GET("/article", func(ctx *gin.Context) {
		context := context.Background()
		articles, err := db.Articles().All(context, database.Repository)
		if err != nil {
			ctx.String(http.StatusInternalServerError, err.Error())
		}
		ctx.PureJSON(200, articles)
	})
	log.Fatal(r.Run())
}