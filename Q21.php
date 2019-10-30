<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
   
   <form action="" method="post">
      Enter number <input type="text" name="number"><br><br>
      <input type="submit" value="Submit" name="submit"> <br><br>
   </form>
   
    
</body>

<?php
    
    if(isset($_POST['submit']))
    {
        
        $num = $_POST['number'];
        
        $temp = $num;
        $count=0;
        $count=strlen($num);
        
        $temp = $num;
        $sum=0;
        while($temp !=0)
        {
            $dig= $temp % 10;
            $sum += pow($dig, $count);
            $temp = $temp / 10;
        }

        if($sum == $num)
            echo "Number is an armstrong number";
        else
            echo "Number is not an armstrong number";
      
    }  
    
?>    
</html>