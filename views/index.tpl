<header>
    <h1>Mis Notas</h1>
    <a href="/add" class="btn btn-primary">+ Nueva Nota</a>
</header>

<section class="search-section">
    <form action="/search" method="get" class="search-container">
        {{.xsrfdata}}
        <input type="text" name="title" class="search-input" placeholder="Buscar por título..." value="{{.SearchTitle}}">
        <button type="submit" class="btn btn-secondary">Buscar</button>
        {{if .SearchTitle}}
            <a href="/" class="btn btn-secondary">Limpiar</a>
        {{end}}
    </form>
</section>

{{if .Error}}
    <div style="background: rgba(255, 77, 77, 0.2); padding: 1rem; border-radius: 12px; margin-bottom: 2rem; border: 1px solid var(--danger-color);">
        {{.Error}}
    </div>
{{end}}

<div class="notes-grid">
    {{range .Notes}}
        <div class="note-card">
            <h3>{{.Title}}</h3>
            <p>{{.Content}}</p>
            <div class="note-footer">
                <span class="note-date">{{.Created.Format "Jan 02, 2006"}}</span>
                <div class="actions">
                    <a href="/edit/{{.Id}}" class="btn btn-secondary" style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">Editar</a>
                    <a href="/delete/{{.Id}}" class="btn btn-danger" onclick="return confirm('¿Seguro que deseas eliminar esta nota?')">Eliminar</a>
                </div>
            </div>
        </div>
    {{else}}
        <div style="grid-column: 1/-1; text-align: center; padding: 4rem; color: var(--muted-text);">
            <p>No se encontraron notas. ¡Crea la primera!</p>
        </div>
    {{end}}
</div>
