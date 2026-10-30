# Garmin Forerunner 55 - Simple Custom Watch Face

Carátula de reloj (*watch face*) minimalista, de alto contraste y ultra bajo consumo de batería diseñada específicamente para el **Garmin Forerunner 55** (pantalla MIP 208×208 px).

---

## Características

* **Batería con icono visual dinámico y %:**
  * Icono vectorial que se rellena según el nivel de carga.
  * Código de color inteligente:
    * 🟢 **Verde:** > 35%
    * 🟡 **Amarillo:** 21% - 35%
    * 🔴 **Rojo:** ≤ 20%
* **Fecha completa:** Día de la semana, día del mes y mes (ej. `VIE, 30 OCT`).
* **Hora digital de gran visibilidad:** Horas y minutos en dígitos grandes (`FONT_NUMBER_HOT`), sin segundero para optimizar la batería al máximo (compatible con formato 12h y 24h).
* **Pasos diarios:** Contador de pasos realizados en el día con formateo de miles (ej. `Pasos: 8.420`).
* **Calorías totales:** Calorías quemadas en el día (ej. `Cal: 1.850 kcal`).
* **Ultra bajo consumo:**
  * Se actualiza únicamente 1 vez por minuto (*Sleep Mode* constante).
  * Sin lecturas continuas de sensores ni llamadas GPS/red.

---

## Requisitos y Configuración

* **Visual Studio Code** con la extensión oficial **Monkey C** (Garmin).
* **Garmin Connect IQ SDK** (v3.2.0 o superior, probado con SDK 6.x y 9.x).
* Dispositivo descargado en el SDK Manager: `fr55`.
* Clave de desarrollador (`developer_key`).

---

## Cómo compilar y ejecutar

### En el Simulador
1. Abre esta carpeta en VS Code.
2. Presiona `F5` para lanzar la carátula en el simulador oficial del Forerunner 55.

### Compilar por línea de comandos
```powershell
monkeyc -o bin/SimpleWatch.prg -f monkey.jungle -y ruta/a/tu/developer_key -d fr55
```

### Instalar en el reloj físico (Side-loading)
1. Conecta el Forerunner 55 al ordenador mediante USB.
2. Copia el archivo `bin/SimpleWatch.prg` a la carpeta `GARMIN/APPS/` del reloj.
3. Desconecta el reloj y selecciónala en el menú: *Mantener pulsado UP > Pantalla del reloj > Simple FR55*.
