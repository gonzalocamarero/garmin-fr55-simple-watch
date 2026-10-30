import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Time.Gregorian;
import Toybox.ActivityMonitor;

class FR55SimpleWatchView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
    }

    function onShow() {
    }

    function onUpdate(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;

        // 1. Fondo negro
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        // 2. Indicador de Batería (Arriba del todo, centrado)
        var stats = System.getSystemStats();
        var battery = (stats != null && stats.battery != null) ? stats.battery : 100.0;
        var batteryInt = battery.toNumber();

        // Determinar color de la batería según nivel
        var batteryColor = Graphics.COLOR_GREEN;
        if (batteryInt <= 20) {
            batteryColor = Graphics.COLOR_RED;
        } else if (batteryInt <= 35) {
            batteryColor = Graphics.COLOR_YELLOW;
        }

        // Icono de batería (18x9 px) + Porcentaje en texto
        var iconWidth = 18;
        var iconHeight = 9;
        var iconY = 15;
        var batteryString = Lang.format("$1$%", [batteryInt]);
        var textWidth = dc.getTextWidthInPixels(batteryString, Graphics.FONT_XTINY);
        var totalBatteryWidth = iconWidth + 5 + textWidth;
        var startX = centerX - (totalBatteryWidth / 2);

        // Contorno y borne de la batería
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawRectangle(startX, iconY, iconWidth, iconHeight);
        dc.fillRectangle(startX + iconWidth, iconY + 2, 2, iconHeight - 4);

        // Relleno de nivel de la batería
        var maxFill = iconWidth - 4;
        var fillWidth = (maxFill * batteryInt / 100).toNumber();
        if (fillWidth > maxFill) {
            fillWidth = maxFill;
        }
        if (fillWidth > 0) {
            dc.setColor(batteryColor, Graphics.COLOR_TRANSPARENT);
            dc.fillRectangle(startX + 2, iconY + 2, fillWidth, iconHeight - 4);
        }

        // Texto del porcentaje de batería
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            startX + iconWidth + 5,
            iconY - 4,
            Graphics.FONT_XTINY,
            batteryString,
            Graphics.TEXT_JUSTIFY_LEFT
        );

        // 3. Fecha (Debajo de la batería)
        var now = Time.now();
        var info = Gregorian.info(now, Time.FORMAT_MEDIUM);
        
        // e.g. "VIE, 30 OCT"
        var dayName = info.day_of_week.toUpper();
        var monthName = info.month.toUpper();
        var dateString = Lang.format("$1$, $2$ $3$", [
            dayName,
            info.day,
            monthName
        ]);

        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            34,
            Graphics.FONT_TINY,
            dateString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // 4. Hora (Centro) - Solo Horas y Minutos (sin segundos)
        var clockTime = System.getClockTime();
        var hour = clockTime.hour;
        var is24Hour = System.getDeviceSettings().is24Hour;
        
        if (!is24Hour) {
            hour = hour % 12;
            if (hour == 0) {
                hour = 12;
            }
        }
        
        var timeString = Lang.format("$1$:$2$", [
            hour.format("%02d"),
            clockTime.min.format("%02d")
        ]);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            62,
            Graphics.FONT_NUMBER_HOT,
            timeString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // Línea divisoria sutil
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(35, 138, width - 35, 138);

        // 5. Métricas de Actividad (Abajo)
        var actInfo = ActivityMonitor.getInfo();
        var steps = 0;
        var calories = 0;

        if (actInfo != null) {
            if (actInfo.steps != null) {
                steps = actInfo.steps;
            }
            if (actInfo.calories != null) {
                calories = actInfo.calories;
            }
        }

        // Formato con punto de miles si supera 999
        var stepsFormatted = formatNumber(steps);
        var calFormatted = formatNumber(calories);

        var stepsString = Lang.format("Pasos: $1$", [stepsFormatted]);
        var calString = Lang.format("Cal: $1$ kcal", [calFormatted]);

        // Dibujar pasos (en verde)
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            145,
            Graphics.FONT_TINY,
            stepsString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // Dibujar calorías (en naranja)
        dc.setColor(Graphics.COLOR_ORANGE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(
            centerX,
            168,
            Graphics.FONT_TINY,
            calString,
            Graphics.TEXT_JUSTIFY_CENTER
        );
    }

    // Función auxiliar para formatear números con separador de miles (ej: 12500 -> 12.500)
    function formatNumber(num) {
        if (num < 1000) {
            return num.toString();
        }
        var thousands = num / 1000;
        var remainder = num % 1000;
        return Lang.format("$1$.$2$", [thousands, remainder.format("%03d")]);
    }

    function onHide() {
    }

    function onExitSleep() {
    }

    function onEnterSleep() {
    }
}
