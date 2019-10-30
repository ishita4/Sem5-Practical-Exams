<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
   
   <form action="" method="post">
      Enter starting <input type="text" name="start"><br><br>
      Enter ending <input type="text" name="end"> <br><br>
      <input type="submit" value="Submit" name="submit"> <br><br>
   </form>
   
    
</body>

<?php
    
    if(isset($_POST['start'], $_POST['end']))
    {
        $start = $_POST['start'];
        $end = $_POST['end'];

        //echo $start;

        for($i= $start; $i <= $end ; $i++ )
        {
            for($j= 2; $j < $i ; $j++ )
            {
                if ($i % $j == 0)
                    break;
            }

            if ($j == $i)
                echo $i." ";
        }
    }
    
    
    
    
    
?>    
</html>