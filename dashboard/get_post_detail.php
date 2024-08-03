<?php
include 'db.php';

header('Content-Type: application/json');

$id = $_GET['id'];
$sql = "SELECT * FROM posts WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

$post = $result->fetch_assoc();

echo json_encode($post);

$stmt->close();
$conn->close();
?>
