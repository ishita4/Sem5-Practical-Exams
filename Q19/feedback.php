<?php

include ("connection.php");

$exp= $_POST['exp'];
$comment= $_POST['comment'];
$name= $_POST['name'];
$email= $_POST['email'];

/*echo "".$exp."<br>";
echo $comment;
echo $name;
echo $comment;*/

$sql="insert into data values('$exp','$comment','$name','$email')";
$result= $conn->query($sql);

$sql="select * from data";
$result= $conn->query($sql);
echo "<table border='1' cellpadding='5px'>";
echo "<tr><th>Name</th><th>Email</th><th>Experience</th><th>Comments</th></tr>";
if($result -> num_rows > 0){
    while($row = $result -> fetch_assoc()){
        
        echo "<tr><td>".$row['name']."</td><td>".$row['email']."</td><td>".$row['exp']."</td><td>".$row['comments']."</td></tr>";
    }
}
echo "</table>";

?>

