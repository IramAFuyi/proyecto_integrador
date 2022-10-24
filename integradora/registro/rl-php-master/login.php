<!DOCTYPE html>
<?php session_start(); ?>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">


    <link rel="stylesheet" href="css/estilo.css">
</head>
<body>
          <?php 
          include "php/navbar.php";
          ?>
        <main>

            <div class="contenedor__todo">
                <div class="caja__trasera">
                    <div class="caja__trasera-login">
                        <h3>¿Ya tienes una cuenta?</h3>
                        <p>Inicia sesión para entrar en la página</p>
                        <button id="btn__iniciar-sesion" href="./login.php">Iniciar Sesión</button>
                    </div>
                    <div class="caja__trasera-register">
                        <h3>¿Aún no tienes una cuenta?</h3>
                        <p>Regístrate para que puedas iniciar sesión</p>
                        <button id="btn__registrarse" href="./registro.php">Regístrarse</button>
                    </div>
                </div>

                <!--Formulario de Login y registro-->
                <div class="contenedor__login-register">
                    <!--Login-->
                    <form  role="form" name="login" action="php/login.php" method="post">
                        <h2>Iniciar Sesión</h2>
                        <input type="text"  id="username" name="username" placeholder="Username">
                        <input type="password"  id="password" name="password" placeholder="Contrase&ntilde;a">
                        <button type="submit">Entrar</button>
                    </form>

                    <!--Register-->
                    <form class="formulario__register"role="form" name="registro" action="php/registro.php" method="post">
                        <h2>Regístrarse</h2>
                        <input type="text" class="form-control" id="fullname" name="fullname" placeholder="Fullname">
                        <input type="text" class="form-control" id="username" name="username" placeholder="username">
                        <input type="email" placeholder="Email" id="email" name="email">
                        <input type="password" placeholder="Contrase&ntilde;a" id="password" name="password">
                        <input type="password" class="form-control" id="confirm_password" name="confirm_password" placeholder="Confirmar Contrase&ntilde;a">
                        <button type="submit">Regístrarse</button>
                    </form>
                </div>
            </div>

        </main>

        <script src="../assets/js/script.js"></script>
</body>
</html>