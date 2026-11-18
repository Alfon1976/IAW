<?php
function programas($dia) {
    $pdo = conectar();
    $st = $pdo->prepare('SELECT hora, titulo, resumen FROM programas WHERE dia = ? ORDER BY hora');
    $st->execute([$dia]);
    return $st->fetchAll();
}
