Class cysnet.clinicaDental.agenda.bo.PacientesSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

// Método que crea un nuevo paciente

Method nuevoPaciente(pRequest As cysnet.clinicaDental.agenda.msg.CrearPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.CrearPacienteResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0

    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.CrearPacienteResponse).%New()
    set pResponse.exito = 1

    Try {
        set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
        set sqlObtenerEmail = "SELECT Email FROM cysnet_clinicaDental_data.Pacientes WHERE Email = ?"
        set sc = ..Adapter.ExecuteQuery(.rs, sqlObtenerEmail, pRequest.email)
        if ($$$ISOK(sc)) {
            if (rs.Next(.sc)) {
                quit:$$$ISERR(sc)
                set pResponse.exito = 0
                set pResponse.mensaje = "Ya existe un paciente registrado con el correo electrónico "_pRequest.email
                return $$$OK
            }
        }

        // Si el email no se encuentra registrado entonces crea al paciente
        
        set permiteNotificaciones = 1
        set baja = 0
        set sqlInsertarPaciente = "INSERT INTO cysnet_clinicaDental_data.Pacientes (Nombre, Apellidos, Email, PermiteNotificaciones, Baja) VALUES (?, ?, ?, ?, ?)"
        set sc = ..Adapter.ExecuteUpdate(.numRows, sqlInsertarPaciente, pRequest.nombre, pRequest.apellidos, pRequest.email, permiteNotificaciones, baja)
        
        // Revisa si la sentencia se ejecuta bien
        if ($$$ISOK(sc)) {

            // Revisa si trae resultados
            if (numRows > 0) {
                set pResponse.exito = 1
                set pResponse.mensaje = "Paciente "_pRequest.nombre_" "_pRequest.apellidos_" agregado exitosamente"
                set sc = ..Adapter.ExecuteQuery(.rs, "SELECT LAST_INSERT_ID() AS LastID")
                if ($$$ISOK(sc)) {
                    if (rs.Next(.sc)) {
                        set pResponse.lastID = rs.Get("LastID")
                    } else {
                        set pResponse.exito = 0
                        set pResponse.mensaje = "No se encuentra el Id del registro"
                    }
                }
            } else {
                set pResponse.exito = 0
                set pResponse.mensaje = "No se insertó el paciente "_pRequest.nombre_" "_pRequest.apellidos
            }
        }

    }
    Catch err {
        
        // Si ha ocurrido un error, crear el objeto Status:
        if (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
	        set sc = err.status
        } else {
	        set sc = $System.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
        }
    }

    if ($$$ISERR(sc)) {

        set pResponse.exito = 0
        set pResponse.mensaje = $System.Status.GetErrorText(sc)

    }

    quit $$$OK
}

// Método que da de baja un paciente

Method bajaPaciente(pRequest As cysnet.clinicaDental.agenda.msg.BajaPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BajaPacienteResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0

    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BajaPacienteResponse).%New()
    set pResponse.exito = 1

    Try {
        set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
        set sqlObtenerEmail = "SELECT Email FROM cysnet_clinicaDental_data.Pacientes WHERE Email = ?"
        set sc = ..Adapter.ExecuteQuery(.rs, sqlObtenerEmail, pRequest.email)
        if ($$$ISOK(sc)) {
            if (rs.Next(.sc)) {
                // El correo electrónico existe
                // Hacer el update del campo baja a 1
                set sqlBajaPaciente = "UPDATE cysnet_clinicaDental_data.Pacientes SET Baja = 1 WHERE Email = ?"
                set sc = ..Adapter.ExecuteUpdate(.numRows, sqlBajaPaciente, pRequest.email)
                if ($$$ISOK(sc)) {
                    set pResponse.mensaje = "Paciente con el correo "_pRequest.email_" ha sido dado de baja"
                }
            }
        }

    }
    Catch err {
        
        // Si ha ocurrido un error, crear el objeto Status:
        if (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
	        set sc = err.status
        } else {
	        set sc = $System.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
        }
    }

    if ($$$ISERR(sc)) {

        set pResponse.exito = 0
        set pResponse.mensaje = $System.Status.GetErrorText(sc)

    }

    quit $$$OK
}

// Método que modifica un paciente

Method modificarPaciente(pRequest As cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0

    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse).%New()
    set pResponse.exito = 1

    Try {
        set rs = ##class(EnsLib.SQL.GatewayResultSet).%New()
        set sqlObtenerEmail = "SELECT Email FROM cysnet_clinicaDental_data.Pacientes WHERE Email = ?"
        set sc = ..Adapter.ExecuteQuery(.rs, sqlObtenerEmail, pRequest.emailNuevo)
        if ($$$ISOK(sc)) {
            if (rs.Next(.sc)) {
                // El correo electrónico nuevo existe en otro paciente - No hacer el update
                set pResponse.exito = 0
                set pResponse.mensaje = "Existe otro paciente registrado con el correo electrónico "_pRequest.email
                quit:$$$ISERR(sc)
                return $$$OK
            }
        }

        set sqlModPaciente = "UPDATE cysnet_clinicaDental_data.Pacientes SET Nombre = ? , Apellidos = ? , Email = ? , PermiteNotificaciones = ? WHERE Email = ?"

        set sc = ..Adapter.ExecuteUpdate(.numRows, sqlModPaciente, pRequest.nombreNuevo, pRequest.apellidosNuevo, pRequest.emailNuevo, pRequest.permiteNotificaciones, pRequest.emailActual)
        if ($$$ISOK(sc)) {
            if (numRows > 0) {
                set pResponse.mensaje = "Paciente con el correo "_pRequest.emailNuevo_" ha sido modificado"
            } else {
                set pResponse.exito = 0
                set pResponse.mensaje = "No se actualizó ningún paciente"
            }
        }

    }
    Catch err {
        
        // Si ha ocurrido un error, crear el objeto Status:
        if (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
	        set sc = err.status
        } else {
	        set sc = $System.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
        }
    }

    if ($$$ISERR(sc)) {

        set pResponse.exito = 0
        set pResponse.mensaje = $System.Status.GetErrorText(sc)

    }

    quit $$$OK
}

// Método que lista a los pacientes

Method listarPacientes(pRequest As cysnet.clinicaDental.agenda.msg.ListarPacientesRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ListarPacientesResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0
    
    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ListarPacientesResponse).%New()
    set pResponse.pacientes = ##class(%ListOfObjects).%New()
    set pResponse.exito = 1

    Try {

        if (pRequest.mostrarBajas) {

            set sqlListaPacientes = "SELECT * FROM cysnet_clinicaDental_data.Pacientes"

        } else {
            set sqlListaPacientes = "SELECT * FROM cysnet_clinicaDental_data.Pacientes WHERE Baja = 0"
        }
        
        set sc = ..Adapter.ExecuteQuery(.rs, sqlListaPacientes)
        if ($$$ISOK(sc)) {
            while (rs.%Next()) {
                set paciente = ##class(cysnet.clinicaDental.agenda.msg.struct.Paciente).%New()
                set paciente.id = rs.Get("ID")
                set paciente.nombre = rs.Get("Nombre")
                set paciente.apellidos = rs.Get("Apellidos")
                set paciente.email = rs.Get("Email")
                set paciente.permiteNotificaciones = rs.Get("PermiteNotificaciones")
                set paciente.baja = rs.Get("Baja")
                do pResponse.pacientes.Insert(paciente)
                kill paciente
            }
        }

    }
    Catch err {
        
        // Si ha ocurrido un error, crear el objeto Status:
        if (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
	        set sc = err.status
        } else {
	        set sc = $System.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
        }
    }

    if ($$$ISERR(sc)) {

        set pResponse.exito = 0
        set pResponse.mensaje = $System.Status.GetErrorText(sc)

    }

    quit $$$OK
}

// Método que muestra un paciente basado en su ID

Method buscarPacientePorID(pRequest As cysnet.clinicaDental.agenda.msg.BuscarPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.BuscarPacienteResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0
    
    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.BuscarPacienteResponse).%New()
    set pResponse.exito = 1

    Try {

        set sqlPacientePorID = "SELECT * FROM cysnet_clinicaDental_data.Pacientes WHERE ID = ?"
        
        set sc = ..Adapter.ExecuteQuery(.rs, sqlPacientePorID, pRequest.id)
        if ($$$ISOK(sc)) {
            if (rs.%Next(.sc)) {
                set pResponse.id = rs.Get("ID")
                set pResponse.nombre = rs.Get("Nombre")
                set pResponse.apellidos = rs.Get("Apellidos")
                set pResponse.email = rs.Get("Email")
                set pResponse.permiteNotificaciones = rs.Get("PermiteNotificaciones")
                set pResponse.baja = rs.Get("Baja")
            }
        }

    }
    Catch err {
        
        // Si ha ocurrido un error, crear el objeto Status:
        if (err.%ClassName(1)="common.err.exception") && ($$$ISERR(err.status)) {
	        set sc = err.status
        } else {
	        set sc = $System.Status.Error(err.Code,err.Name,err.Location,err.InnerException)
        }
    }

    if ($$$ISERR(sc)) {

        set pResponse.exito = 0
        set pResponse.mensaje = $System.Status.GetErrorText(sc)

    }

    quit $$$OK
}

XData MessageMap
{
<MapItems>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.CrearPacienteRequest">
    <Method>nuevoPaciente</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.BajaPacienteRequest">
    <Method>bajaPaciente</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest">
    <Method>modificarPaciente</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ListarPacientesRequest">
    <Method>listarPacientes</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.BuscarPacienteRequest">
    <Method>buscarPacientePorID</Method>
    </MapItem>
</MapItems>
}

}
