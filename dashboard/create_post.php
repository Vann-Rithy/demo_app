<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $title = $_POST['title'];
    $description = $_POST['description'];

    // Handle file upload
    if (isset($_FILES['image'])) {
        $image = $_FILES['image'];
        $imagePath = 'uploads/' . basename($image['name']);

        // Check if uploads directory exists, if not, create it
        if (!is_dir('uploads')) {
            mkdir('uploads', 0777, true);
        }

        // Move uploaded file to the server
        if (move_uploaded_file($image['tmp_name'], $imagePath)) {
            $sql = "INSERT INTO posts (image_path, title, description) VALUES ('$imagePath', '$title', '$description')";
            if ($conn->query($sql) === TRUE) {
                echo json_encode(array("status" => "success"));
            } else {
                echo json_encode(array("status" => "error", "message" => $conn->error));
            }
        } else {
            echo json_encode(array("status" => "error", "message" => "Failed to upload image."));
        }
    } else {
        echo json_encode(array("status" => "error", "message" => "No image file uploaded."));
    }

    $conn->close();
}
?>
