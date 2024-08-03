<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>Post Dashboard</h1>
    </header>
    <main>
        <section id="post-form">
            <h2>Create Post</h2>
            <form id="create-post-form" enctype="multipart/form-data">
                <input type="file" id="image" name="image" accept="image/*" required>
                <input type="text" id="title" placeholder="Title" required>
                <textarea id="description" placeholder="Description" required></textarea>
                <button type="submit">Create Post</button>
            </form>
        </section>
        <section id="post-list">
            <h2>Post List</h2>
            <table>
                <thead>
                    <tr>
                        <th>Image</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="post-table-body">
                    <!-- Posts will be injected here -->
                </tbody>
            </table>
        </section>
    </main>
    <script src="scripts.js"></script>
</body>
</html>
