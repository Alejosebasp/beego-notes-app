// Package routers defines the URL routing for the application.
package routers

import (
	"notes-app/controllers"
	beego "github.com/beego/beego/v2/server/web"
)

// init registers the application routes and maps them to handler methods.
func init() {
    beego.Router("/", &controllers.NoteController{}, "get:Index")
    beego.Router("/search", &controllers.NoteController{}, "get:Search")
    beego.Router("/add", &controllers.NoteController{}, "get,post:AddNote")
    beego.Router("/edit/:id", &controllers.NoteController{}, "get,post:EditNote")
    beego.Router("/delete/:id", &controllers.NoteController{}, "get:DeleteNote")
}
