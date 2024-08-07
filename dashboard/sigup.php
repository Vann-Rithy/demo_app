<?php
// Database connection
$servername = "localhost";
$username = "plexustrust_user_api";
$password = "5o{B@ki_zu)w";
$dbname = "plexustrust_api";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get POST data
$phone = $_POST['phone'];
$password = $_POST['password'];

// Validate input
if (empty($phone) || empty($password)) {
    echo json_encode(['success' => false, 'message' => 'Phone number and password are required.']);
    exit();
}

// Check if phone number already exists
$sql = "SELECT * FROM signup WHERE phone = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $phone);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    echo json_encode(['success' => false, 'message' => 'Phone number already registered.']);
    exit();
}

// Hash password
$hashed_password = password_hash($password, PASSWORD_BCRYPT);

// Insert user data
$sql = "INSERT INTO signup (phone, password) VALUES (?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $phone, $hashed_password);
if (!$stmt->execute()) {
    echo json_encode(['success' => false, 'message' => 'Failed to register user.']);
    exit();
}

// Generate OTP
$otp = rand(100000, 999999);

// Insert OTP into database
$sql = "INSERT INTO otp_verifications (phone, otp) VALUES (?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $phone, $otp);
if (!$stmt->execute()) {
    echo json_encode(['success' => false, 'message' => 'Failed to generate OTP.']);
    exit();
}

// Send OTP to Telegram Bot
$telegramBotToken = '7041944201:AAHBS5Ay4jfP-Dhr88FNG6093u1pVOKb0KA';
$chatId = '5110093561'; // Replace with your chat ID
$message = "Your OTP is: $otp";

function sendTelegramMessage($token, $chatId, $message) {
    $url = "https://api.telegram.org/bot$token/sendMessage";
    $postFields = [
        'chat_id' => $chatId,
        'text' => $message,
    ];
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postFields));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $result = curl_exec($ch);
    curl_close($ch);
    return $result;
}

if (sendTelegramMessage($telegramBotToken, $chatId, $message)) {
    echo json_encode(['success' => true, 'message' => 'OTP sent to your phone.']);
} else {
    echo json_encode(['success' => false, 'message' => 'Failed to send OTP to Telegram.']);
}

$conn->close();
?>
