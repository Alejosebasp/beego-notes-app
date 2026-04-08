<header>
    <h1>Editar Nota</h1>
    <a href="/" class="btn btn-secondary">Volver</a>
</header>

<div class="form-container">
    {{if .Error}}
        <div style="background: rgba(255, 77, 77, 0.2); padding: 1rem; border-radius: 12px; margin-bottom: 3rem; border: 1px solid var(--danger-color);">
            {{.Error}}
        </div>
    {{end}}

    <form method="post">
        {{.xsrfdata}}
        <div class="form-group">
            <label for="title">Título</label>
            <input type="text" name="title" id="title" class="form-control" required value="{{.Note.Title}}" placeholder="Ingresa el título...">
        </div>
        <div class="form-group">
            <label for="content">Contenido</label>
            <textarea name="content" id="content" class="form-control" required placeholder="Escribe tu nota aquí...">{{.Note.Content}}</textarea>
        </div>
        <button type="submit" class="btn btn-primary" style="width: 100%;">Actualizar Nota</button>
    </form>
</div>
