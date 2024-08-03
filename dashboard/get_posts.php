<?php
include 'db.php';

// Set header for JSON response
header('Content-Type: application/json');

// Initialize the array to hold posts
$posts = array();

// Prepare and execute the SQL query
$sql = "SELECT * FROM posts ORDER BY created_at DESC";
if ($result = $conn->query($sql)) {
    // Fetch posts from the result set
    while ($row = $result->fetch_assoc()) {
        $posts[] = $row;
    }
    // Free result set
    $result->free();
} else {
    // SQL error
    http_response_code(500);
    echo json_encode(array("error" => "Database query failed"));
    exit();
}

// Close the database connection
$conn->close();

// Return the posts as JSON
echo json_encode($posts);
?>
