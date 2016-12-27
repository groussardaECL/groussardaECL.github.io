<?php

/**
if (isset($_POST['utilisateur']) and isset($_POST['passwordUser'])) {

    try
    {
        global $bdd;
        $bdd = new PDO('mysql:host=localhost:3306;dbname=bdd_garage',$_POST['utilisateur'],$_POST['passwordUser']);
    }
    catch (Exception $e)
    {
        die ('Une erreur lors de la connexion à la base de données est survenue : '. $e->getMessage());
    }
    header('Location: dashboard.php');

    if (isset($bdd))
    {
        header('Location: dashboard.php');
        die();
    }

}
*/

/** Connexion à la base de données, avec récupération et affichage de l'erreur */
try
{
    $bdd = new PDO('mysql:host=localhost:3306;dbname=bdd_garage','root','root');
}
catch (Exception $e)
{
    die ('Une erreur lors de la connexion à la base de données est survenue : '. $e->POSTMessage());
}

/**
 * Created by PhpStorm.
 * User: GROUSSARD
 * Date: 21/12/2016
 * Time: 21:36
 */