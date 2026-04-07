// Package main is the entry point for the Beego Notes application.
package main

import (
	_ "notes-app/routers"
	"github.com/beego/beego/v2/client/orm"
	beego "github.com/beego/beego/v2/server/web"
	_ "github.com/mattn/go-sqlite3"
)

// init initializes the database driver, registers the SQLite database, and synchronizes the models.
func init() {
	orm.RegisterDriver("sqlite3", orm.DRSqlite)
	orm.RegisterDataBase("default", "sqlite3", "notes.db")
	
	// Create table if not exists
	orm.RunSyncdb("default", false, true)
}

// main starts the Beego web server.
func main() {
	beego.Run()
}
