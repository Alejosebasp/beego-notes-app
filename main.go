// Package main is the entry point for the Beego Notes application.
package main

import (
	"os"
	"strconv"
	"notes-app/models"
	_ "notes-app/routers"
	"github.com/beego/beego/v2/client/orm"
	beego "github.com/beego/beego/v2/server/web"
	_ "github.com/mattn/go-sqlite3"
)

// init initializes the database driver, registers the SQLite database, and synchronizes the models.
func init() {
	dbPath := os.Getenv("DB_PATH")
	if dbPath == "" {
		dbPath = "notes.db"
	}

	orm.RegisterDriver("sqlite3", orm.DRSqlite)
	orm.RegisterDataBase("default", "sqlite3", dbPath)
	
	// Create table if not exists.
	orm.RunSyncdb("default", false, true)
}

// main starts the Beego web server and seeds the database if empty.
func main() {
	// Seed database if empty
	count, _ := orm.NewOrm().QueryTable("note").Count()
	if count == 0 {
		note := models.Note{
			Title:   "Bienvenida - Banco Caja Social",
			Content: "Esta es tu primera nota en el sistema seguro. ¡Bienvenido!",
		}
		models.AddNote(&note)
	}

	// Configure Beego strictly for HTTPS on a non-root port
	beego.BConfig.Listen.EnableHTTP = false
	beego.BConfig.Listen.EnableHTTPS = true
	
	hPort := os.Getenv("HTTPS_PORT")
	if hPort == "" {
		hPort = "8443"
	}
	portInt, _ := strconv.Atoi(hPort)
	beego.BConfig.Listen.HTTPSPort = portInt
	
	beego.BConfig.Listen.HTTPSCertFile = os.Getenv("HTTPS_CERT")
	beego.BConfig.Listen.HTTPSKeyFile = os.Getenv("HTTPS_KEY")
	
	beego.Run()
}
