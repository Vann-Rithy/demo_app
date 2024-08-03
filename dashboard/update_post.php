<?php
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'];
    $title = $_POST['title'];
    $description = $_POST['description'];
    $imagePath = $_POST['image_path'];

    // Handle file upload if a new file is uploaded
    if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
        $image = $_FILES['image'];
        $imagePath = 'uploads/' . basename($image['name']);

        // Move uploaded file to the server
        if (move_uploaded_file($image['tmp_name'], $imagePath)) {
            // Delete old image file if exists
            $oldImagePath = $_POST['old_image_path'];
            if (file_exists($oldImagePath)) {
                unlink($oldImagePath);
            }
        } else {
            echo json_encode(array("status" => "error", "message" => "Failed to upload image."));
            exit();
        }
    }

    $sql = "UPDATE posts SET image_path='$imagePath', title='$title', description='$description' WHERE id=$id";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(array("status" => "success"));
    } else {
        echo json_encode(array("status" => "error", "message" => $conn->error));
    }

    $conn->close();
}
?>
