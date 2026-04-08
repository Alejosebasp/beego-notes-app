// Package controllers contains the request handlers for the application.
package controllers

import (
	"html/template"
	"notes-app/models"
	beego "github.com/beego/beego/v2/server/web"
)

// NoteController handles all web requests related to notes (CRUD and Search).
type NoteController struct {
	beego.Controller
}

// Index displays the main dashboard with a list of all notes.
func (c *NoteController) Index() {
	notes, err := models.GetAllNotes()
	if err != nil {
		c.Data["Error"] = err.Error()
	}
	c.Data["Notes"] = notes
	c.Data["xsrfdata"] = template.HTML(c.XSRFFormHTML())
	c.Layout = "layout.tpl"
	c.TplName = "index.tpl"
}

// Search handles requests to filter notes by title via a GET query parameter.
func (c *NoteController) Search() {
	title := c.GetString("title")
	notes, err := models.SearchNotes(title)
	if err != nil {
		c.Data["Error"] = err.Error()
	}
	c.Data["Notes"] = notes
	c.Data["SearchTitle"] = title
	c.Data["xsrfdata"] = template.HTML(c.XSRFFormHTML())
	c.Layout = "layout.tpl"
	c.TplName = "index.tpl"
}

// AddNote renders the creation form (GET) or processes the form submission (POST).
func (c *NoteController) AddNote() {
	if c.Ctx.Input.Method() == "POST" {
		title := c.GetString("title")
		content := c.GetString("content")
		
		note := models.Note{
			Title:   title,
			Content: content,
		}
		
		_, err := models.AddNote(&note)
		if err != nil {
			c.Data["Error"] = err.Error()
			c.Data["xsrfdata"] = template.HTML(c.XSRFFormHTML())
			c.Layout = "layout.tpl"
			c.TplName = "add.tpl"
			return
		}
		c.Redirect("/", 302)
		return
	}
	c.Data["xsrfdata"] = template.HTML(c.XSRFFormHTML())
	c.Layout = "layout.tpl"
	c.TplName = "add.tpl"
}

// EditNote renders the update form (GET) or processes changes (POST) for an existing note.
func (c *NoteController) EditNote() {
	id, _ := c.GetInt(":id")
	if c.Ctx.Input.Method() == "POST" {
		title := c.GetString("title")
		content := c.GetString("content")
		
		note := models.Note{
			Id:      id,
			Title:   title,
			Content: content,
		}
		
		_, err := models.UpdateNote(&note)
		if err != nil {
			c.Data["Error"] = err.Error()
			c.Data["Note"] = note
			c.Data["xsrfdata"] = template.HTML(c.XSRFFormHTML())
			c.Layout = "layout.tpl"
			c.TplName = "edit.tpl"
			return
		}
		c.Redirect("/", 302)
		return
	}
	
	note, err := models.GetNoteById(id)
	if err != nil {
		c.Redirect("/", 302)
		return
	}
	c.Data["Note"] = note
	c.Data["xsrfdata"] = template.HTML(c.XSRFFormHTML())
	c.Layout = "layout.tpl"
	c.TplName = "edit.tpl"
}

// DeleteNote removes a note from the system using the ID provided in the URL.
func (c *NoteController) DeleteNote() {
	id, _ := c.GetInt(":id")
	_, err := models.DeleteNote(id)
	if err != nil {
		c.Ctx.WriteString("Error deleting note")
		return
	}
	c.Redirect("/", 302)
}
