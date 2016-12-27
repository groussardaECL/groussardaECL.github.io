<?php
require "connexion2.php";

if ( $_SERVER['REQUEST_METHOD'] != 'POST' ) die ('Illegal call');

$bdd->exec('INSERT INTO clients(nom, prenom, nomCommune, IDreferent) VALUES (\''
    .$_POST['nom']. '\',\''
    .$_POST['prenom']. '\',\''
    .$_POST['nomCommune']. '\','
    .$_POST['referent']. ');') or die(mysqli_error());
?>
<html>
<head>
    <title>new</title>
    <script type="text/javascript">location.href="add-client.php"</script>
</head>
<body></body>
</html>
