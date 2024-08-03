document.addEventListener('DOMContentLoaded', () => {
    loadPosts();

    document.getElementById('create-post-form').addEventListener('submit', function(e) {
        e.preventDefault();
        createPost();
    });
});

function loadPosts() {
    fetch('http://192.168.65.1:8000/get_posts.php')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('post-table-body');
            tableBody.innerHTML = '';
            data.forEach(post => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td><img src="${post.image_path}" alt="Post Image"></td>
                    <td>${post.title}</td>
                    <td>${post.description}</td>
                    <td>
                        <button onclick="editPost(${post.id}, '${post.image_path}')">Edit</button>
                        <button onclick="deletePost(${post.id}, '${post.image_path}')">Delete</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        });
}

function createPost() {
    const formData = new FormData();
    formData.append('title', document.getElementById('title').value);
    formData.append('description', document.getElementById('description').value);
    formData.append('image', document.getElementById('image').files[0]);

    fetch('http://192.168.65.1:8000/create_post.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.json())
    .then(data => {
        if (data.status === 'success') {
            alert('Post created successfully');
            loadPosts();
        } else {
            alert('Error: ' + data.message);
        }
    });
}

function deletePost(id, imagePath) {
    if (confirm('Are you sure you want to delete this post?')) {
        fetch('http://192.168.65.1:8000/delete_post.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: new URLSearchParams({ id: id })
        })
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                alert('Post deleted successfully');
                loadPosts();
            } else {
                alert('Error: ' + data.message);
            }
        });
    }
}
