<?php require "connexion2.php"; ?>
<!DOCTYPE html>
<html lang="fr">
<!-- From Bootstrap Example document -->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">

    <title>Garage - Clients</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="css/dashboard.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<?php include "inc/header.html"; ?>

<div class="container-fluid">
    <div class="row">
        <?php include "inc/side-bar.html"; ?>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">Dashboard - Clients</h1>
            <h2 class="sub-header">Liste des clients</h2>
            <div class="table-responsive col-md-8">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID Client</th>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Commune</th>
                        <th>Reférent</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php
                    $reponse = $bdd->query('SELECT IDclient, c.nom as nomc, c.prenom as prenomc, nomCommune, r.nom as nomr, r.prenom as prenomr, c.IDreferent FROM clients as c, referents as r WHERE c.IDreferent=r.IDreferent;');
                    while ($donnees = $reponse->fetch())
                    {
                        echo '<tr>';
                        echo '<td><a href="client.php?idclient='.$donnees['IDclient'].'">'.$donnees['IDclient'].'</a></td>';
                        echo '<td><a href="client.php?idclient='.$donnees['IDclient'].'">'.$donnees['nomc'].'</a></td>';
                        echo '<td><a href="client.php?idclient='.$donnees['IDclient'].'">'.$donnees['prenomc'].'</a></td>';
                        echo '<td>'.$donnees['nomCommune'].'</td>';
                        echo '<td><a href="referent.php?idreferent='.$donnees['IDreferent'].'">'.$donnees['prenomr']. ' ' .$donnees['nomr']. '</a></td>';
                        echo '<td>';
                        /**echo '<a class="delete" href="delete.php?ID='.$a['ID'].'"'.
                            ' onclick="return confirm(\'Voulez-vous vraiment supprimer ces Jeux Olympiques ?\')")>X</a>&nbsp;';
                        echo '<a href="detail.php?ID='.$a['ID'].'">'.$a['Annee'].'</a>';
                        echo '</td>'; */
                        echo '</tr>';
                    }
                    ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<nav class="navbar navbar-inverse navbar-fixed-bottom">
    <div class="container-fluid">
        <div class="navbar-footer col-sm-3 col-md-2">
            <a class="navbar-brand" href="#">Actions</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-middle">
                <li>
                    <a href="add-client.php">
                        <img src="img/add-icon.png" width="16" height="16" class="img" alt="+">
                        Ajout d'un nouveau client
                    </a>
                </li>
                <li>
                    <a href="recherche-client.php">
                        <img src="img/search-icon.png" width="16" height="16" class="img" alt="+">
                        Recherche
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

</body>
</html>