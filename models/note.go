// Package models defines the data structures and database operations for the application.
package models

import (
	"time"
	"github.com/beego/beego/v2/client/orm"
)

// Note represents a single note in the system.
// It contains a unique Id, Title, Content, and the time it was created.
type Note struct {
	Id      int       `orm:"auto"`
	Title   string    `orm:"size(100)"`
	Content string    `orm:"type(text)"`
	Created time.Time `orm:"auto_now_add;type(datetime)"`
}

func init() {
	// Register model with Beego ORM.
	orm.RegisterModel(new(Note))
}

// SearchNotes filters notes by a title substring (case-insensitive).
// Returns a list of matching notes sorted by creation date (newest first).
func SearchNotes(title string) ([]*Note, error) {
	o := orm.NewOrm()
	var notes []*Note
	_, err := o.QueryTable("note").Filter("title__icontains", title).OrderBy("-created").All(&notes)
	return notes, err
}

// GetAllNotes retrieves all notes from the database.
// Results are sorted by creation date (newest first).
func GetAllNotes() ([]*Note, error) {
	o := orm.NewOrm()
	var notes []*Note
	_, err := o.QueryTable("note").OrderBy("-created").All(&notes)
	return notes, err
}

// AddNote inserts a new note into the SQLite database.
func AddNote(note *Note) (int64, error) {
	o := orm.NewOrm()
	id, err := o.Insert(note)
	return id, err
}

// GetNoteById finds a single note by its unique identifier.
func GetNoteById(id int) (*Note, error) {
	o := orm.NewOrm()
	note := &Note{Id: id}
	err := o.Read(note)
	return note, err
}

// UpdateNote persists changes to an existing note.
func UpdateNote(note *Note) (int64, error) {
	o := orm.NewOrm()
	id, err := o.Update(note)
	return id, err
}

// DeleteNote removes a note from the system by Id.
func DeleteNote(id int) (int64, error) {
	o := orm.NewOrm()
	id_int64, err := o.Delete(&Note{Id: id})
	return id_int64, err
}
