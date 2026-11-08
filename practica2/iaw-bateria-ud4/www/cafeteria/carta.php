<?php
// Batería UD4 · bloque 2 · La carta. Apartado 4 de la UD4.
// Pruébala en https://localhost:8447/carta.php (cuando el bloque 1 funcione).
declare(strict_types=1);
$titulo = 'Carta · Cafetería';
$platos = require __DIR__ . '/inc/platos.php';   // la lista de platos: míralo en inc/platos.php
require __DIR__ . '/inc/cabecera.php';

// ✍️ 2.2 · Una función euros() que reciba un número (float) y devuelva el precio en texto,
//    con dos decimales, coma decimal y el símbolo del euro: 3.2 → «3,20 €». Pista: number_format.

function euros(float $precio): string {
    return number_format($precio, 2, ',', '.') . ' €';
}



?>
<h2>La carta</h2>
<ul id="carta">
<?php 
// ✍️ 2.1 · Un <li> por plato: «nombre — precio» (el precio, con tu euros()). Pista: foreach. 
if (is_array($platos)) {
    foreach ($platos as $plato) {
        $precioActual = (float)$plato['precio'];
        $total += $precioActual; // Vamos sumando al total sobre la marcha
        echo "<li>" . htmlspecialchars($plato['nombre']) . " — " . euros($precioActual) . "</li>";
    }
}
?>
</ul>

<p id="total">Total de la carta: <?php echo euros($total); ?></p>




<h2>Para vegetarianos</h2>
<ul id="vegetarianos">
<?php 
// ✍️ 2.4 · Quédate solo con los vegetarianos (array_filter) y pinta otra lista igual que la de arriba. 
$vegetarianos = array_filter($platos, fn($p) => (bool)$p['vegetariano']);

foreach ($vegetarianos as $plato) {
    echo "<li>" . htmlspecialchars($plato['nombre']) . " — " . euros((float)$plato['precio']) . "</li>";
}
?>
</ul>
</body></html>