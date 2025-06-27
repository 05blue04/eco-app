package main

import (
	"github.com/05blue04/eco-app/routes"
	"github.com/05blue04/eco-app/config"
)

func main() {
	config.LoadEnv()
	router := routes.SetupRouter()
	router.Run(":8080")
}
