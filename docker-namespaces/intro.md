La tecnología de contenedores hace uso de varias características presentes en los últimos kernel de Linux que permiten aislar ("conteneirizar") procesos. Esto permite instalar y ejecutar múltiples servicios en un mismo Host sin que exista visibilidad entre ellos. Este aislamiento se produce en los siguientes niveles:
- User Namespace.
- Unix Time-Sharing Namespace.
- IPC Namespace.
- Mount Namespace.
- PID Namespace.
- Network Namespace.

