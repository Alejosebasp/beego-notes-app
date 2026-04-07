<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{{.Title}} - Notas App</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-color: #00253d;
            --card-bg: rgba(255, 255, 255, 0.05);
            --card-border: rgba(255, 255, 255, 0.1);
            --text-color: #ffffff;
            --accent-color: #0099ff;
            --danger-color: #ff4d4d;
            --muted-text: rgba(255, 255, 255, 0.6);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Outfit', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-color);
            min-height: 100vh;
            padding: 2rem 1rem;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 3rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 600;
            background: linear-gradient(45deg, #fff, #0099ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .btn {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
            border: none;
            font-size: 1rem;
        }

        .btn-primary {
            background-color: var(--accent-color);
            color: white;
            box-shadow: 0 4px 15px rgba(0, 153, 255, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 153, 255, 0.4);
        }

        .btn-secondary {
            background-color: var(--card-bg);
            color: white;
            border: 1px solid var(--card-border);
        }

        .btn-secondary:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .btn-danger {
            background-color: transparent;
            color: var(--danger-color);
            font-size: 0.9rem;
            padding: 0.5rem 1rem;
        }

        .btn-danger:hover {
            background-color: rgba(255, 77, 77, 0.1);
        }

        .search-container {
            width: 100%;
            margin-bottom: 2rem;
            display: flex;
            gap: 0.5rem;
        }

        .search-input {
            flex: 1;
            padding: 0.8rem 1.2rem;
            border-radius: 12px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            color: white;
            outline: none;
            transition: border-color 0.3s;
        }

        .search-input:focus {
            border-color: var(--accent-color);
        }

        .notes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
        }

        .note-card {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 1.5rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .note-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(255, 255, 255, 0.2);
        }

        .note-card h3 {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .note-card p {
            color: var(--muted-text);
            line-height: 1.6;
            font-size: 0.95rem;
            word-break: break-word;
            flex-grow: 1;
        }

        .note-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--card-border);
        }

        .note-date {
            font-size: 0.8rem;
            color: var(--muted-text);
        }

        .form-container {
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            max-width: 600px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--muted-text);
            font-size: 0.9rem;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1.2rem;
            border-radius: 12px;
            background: rgba(0, 0, 0, 0.2);
            border: 1px solid var(--card-border);
            color: white;
            outline: none;
            font-size: 1rem;
        }

        .form-control:focus {
            border-color: var(--accent-color);
        }

        textarea.form-control {
            min-height: 150px;
            resize: vertical;
        }

        .actions {
            display: flex;
            gap: 1rem;
        }

        @media (max-width: 600px) {
            header {
                flex-direction: column;
                align-items: flex-start;
            }
            .search-container {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        {{.LayoutContent}}
    </div>
</body>
</html>
