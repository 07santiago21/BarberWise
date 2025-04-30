# Historias de Usuario - BarberWise 

---

## Autenticación

### 1. Registro de barbero

**Como** barbero,  
**Quiero** poder registrarme con mi foto, nombre, correo, número y contraseña,  
**Para** crear mi cuenta y comenzar a usar la app.

**Criterios de aceptación:**
- CA1. El formulario de registro debe tener campos obligatorios: nombre, correo, número, contraseña.
- CA2. El sistema debe validar que el correo no esté ya registrado.
- CA3. Al registrarse correctamente, el usuario debe ser redirigido al dashboard.
- CA4. Si falta algún campo o hay error, debe mostrarse un mensaje claro.

---

### 2. Inicio de sesión
**Como** barbero,  
**Quiero** poder iniciar sesión con mi correo y contraseña,  
**Para** acceder a mi cuenta.

**Criterios de aceptación:**
- CA1. Solo los usuarios registrados deben poder iniciar sesión.
- CA2. Si las credenciales son incorrectas, se debe mostrar un mensaje de error.
- CA3. Al iniciar sesión correctamente, el usuario debe ser llevado al dashboard.

---

## Dashboard

### 3. Ver próximo turno del día
**Como** barbero,  
**Quiero** ver en el dashboard el próximo turno del día,  
**Para** saber a quién debo atender primero.

**Criterios de aceptación:**
- CA1. El sistema debe mostrar el turno más próximo basado en la hora actual.
- CA2. Debe incluir información como nombre del cliente, hora y tipo de corte.

---

### 4. Ver cantidad de turnos realizados hoy
**Como** barbero,  
**Quiero** ver la cantidad de turnos realizados hoy,  
**Para** tener un control de mi jornada.

**Criterios de aceptación:**
- CA1. Deben contarse solo los turnos cuya hora ya haya pasado.
- CA2. La cantidad debe actualizarse en tiempo real o al refrescar la app.

---

### 5. Ver dinero generado hoy
**Como** barbero,  
**Quiero** ver el total de dinero generado hoy,  
**Para** saber cuánto he ganado.

**Criterios de aceptación:**
- CA1. El total debe calcularse en base a los turnos ya realizados.
- CA2. Debe estar expresado en la moneda local.

---

### 6. Ver total de turnos del día
**Como** barbero,  
**Quiero** ver el total de turnos programados para el día,  
**Para** planificar mi tiempo.

**Criterios de aceptación:**
- CA1. Debe incluir todos los turnos del día actual, sin importar si ya pasaron.
- CA2. El dato debe actualizarse si se agregan o eliminan reservas.

---

### 7. Ver ganancias esperadas del día
**Como** barbero,  
**Quiero** ver las ganancias esperadas del día,  
**Para** anticipar mis ingresos.

**Criterios de aceptación:**
- CA1. Debe sumar los precios de todos los turnos agendados para hoy.
- CA2. El dato debe actualizarse si se agregan o eliminan reservas.

---

## Estadísticas

### 8. Filtrar por rango de fechas
**Como** barbero,  
**Quiero** seleccionar un rango de fechas para filtrar mis estadísticas (7 dias, 15 dias, 30 dias),  
**Para** revisar mi rendimiento en ese periodo.

**Criterios de aceptación:**
- CA1. El usuario debe poder seleccionar el rango de fechas deseado entre 7,15 y 30 dias.
- CA2. Los resultados deben actualizarse automáticamente al aplicar el filtro.

---

### 9. Ver dinero ganado en un rango
**Como** barbero,  
**Quiero** ver cuánto dinero gané en el rango de tiempo seleccionado,  
**Para** analizar mis ingresos.

**Criterios de aceptación:**
- CA1. El total debe incluir solo los turnos realizados dentro del rango.
---

### 10. Ver cantidad total de cortes realizados
**Como** barbero,  
**Quiero** ver la cantidad total de cortes realizados en ese tiempo,  
**Para** evaluar mi productividad.

**Criterios de aceptación:**
- CA1. El número debe coincidir con la cantidad de reservas completadas en el rango.
---

### 11. Ver mejor día por cantidad de cortes
**Como** barbero,  
**Quiero** ver cuál fue el mejor día en cantidad de cortes,  
**Para** identificar mis días más activos.

**Criterios de aceptación:**
- CA1. Debe mostrarse la fecha y la cantidad de cortes.
- CA2. La comparación debe basarse solo en los datos del rango seleccionado.

---

## Calendario

### 12. Ver turnos del día en el calendario
**Como** barbero,  
**Quiero** ver todos los turnos del día en una vista de calendario,  
**Para** organizar mi tiempo.

**Criterios de aceptación:**
- CA1. Debe mostrarse una vista organizada por bloques horarios. 
- CA2. Cada turno debe mostrarse con hora, cliente y tipo de corte.

---

### 13. Cambiar la fecha en el calendario
**Como** barbero,  
**Quiero** poder cambiar la fecha en el calendario,  
**Para** ver los turnos de días futuros.

**Criterios de aceptación:**
- CA1. Al seleccionar otra fecha, deben cargarse los turnos de ese día.
- CA2. Si no hay turnos, debe mostrarse un mensaje informativo.

---

### 14. Acceder a crear nueva reserva desde el calendario
**Como** barbero,  
**Quiero** acceder fácilmente a una pantalla para crear una nueva reserva desde el calendario,  
**Para** añadir nuevos turnos rápidamente.

**Criterios de aceptación:**
- CA1. El botón de crear reserva debe estar visible y accesible.
- CA2. Al presionar, debe redirigir a la pantalla de creación.

---

## Crear Reserva

### 15. Crear una reserva
**Como** barbero,  
**Quiero** poder crear una reserva ingresando el nombre del cliente, la hora, tipo de corte y número de celular,  
**Para** agendar un nuevo turno.

**Criterios de aceptación:**
- CA1. Todos los campos deben ser obligatorios.
- CA2. El sistema debe validar que no haya otro turno en la misma hora.
- CA3. Al guardar, la reserva debe aparecer en el calendario.
- CA4. Si ocurre un error, debe mostrarse un mensaje claro.

---

## Perfil

### 16. Editar perfil de barbero
**Como** barbero,  
**Quiero** poder editar mi nombre, foto, número y correo electrónico,  
**Para** mantener mi perfil actualizado.

**Criterios de aceptación:**
- CA1. El formulario debe precargar los datos actuales del usuario.
- CA2. Los cambios deben guardarse correctamente y reflejarse en la app.
- CA3. Si hay errores en los campos, debe mostrarse un mensaje claro.
