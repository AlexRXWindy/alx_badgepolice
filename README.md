Este script permite la gestión de números de placas para jugadores en un servidor de FiveM. Los administradores o policías pueden asignar y modificar placas a otros jugadores, así como consultar su propia placa. Es compatible tanto con QBCore como con ESX, detectando automáticamente el framework en uso.

# Funcionalidades
Generar Placas:

Los policías con nivel adecuado pueden asignar números de placas a otros jugadores.

Modificar Placas:

Los policías pueden cambiar la placa de un jugador objetivo.

Consultar Placa:

Los jugadores pueden ver su número de placa actual.

Export de Placas:

Puedes acceder a la placa de un jugador directamente desde otros scripts mediante un export.

# Instalación
Descarga el script y colócalo en tu carpeta de recursos.
Asegúrate de que las dependencias requeridas (qb-core, es_extended) estén instaladas y correctamente configuradas.
Añade el recurso a tu archivo server.cfg:
cfg
Copiar código
ensure script-placas
Crea una carpeta data/ dentro del recurso y asegúrate de que tenga permisos de escritura para guardar los datos en plate_numbers.json.
Comandos
/generarplaca [PlayerID]
Genera un número de placa para un jugador objetivo.

Requisitos:
Ser policía.
Tener un nivel de trabajo adecuado.
/modificarplaca [PlayerID] [NuevoNúmeroDePlaca]
Modifica el número de placa de un jugador objetivo.

Requisitos:
Ser policía.
Tener un nivel de trabajo adecuado.
/miplaca
Consulta tu número de placa actual.

Exports
Este script incluye un export para acceder a los números de placa desde otros scripts.

Export Disponible
lua
Copiar código
exports['script-placas']:getPlateNumber(citizenId)
Uso
Puedes llamar a este export desde cualquier script en tu servidor para obtener la placa de un jugador:

lua
Copiar código
local plateNumber = exports['script-placas']:getPlateNumber('CID12345')
if plateNumber then
    print('La placa del jugador es: ' .. plateNumber)
else
    print('No se encontró un número de placa para este jugador.')
end
Requisitos
Frameworks Compatibles:
QBCore
ESX
Notificaciones:
Para ESX, puedes usar cualquier sistema de notificaciones que soporte exports, como Mythic Notify.
Configuración
Si deseas personalizar el script, puedes modificar las siguientes partes:

Generación de Placas: Cambia la lógica de generatePlateNumber() para ajustar el formato del número de placa.
Notificaciones: Cambia la función notify(message, type) para usar otro sistema de notificaciones.
Contribución
Si deseas mejorar el script o añadir nuevas funcionalidades, crea un pull request o abre un issue en el repositorio del proyecto.

Soporte
Si encuentras problemas al usar este script o necesitas ayuda, puedes contactarnos mediante nuestra página de soporte o unirte a nuestro servidor de Discord.

¡Disfruta de tu experiencia de juego con este sistema de gestión de placas! 🚓