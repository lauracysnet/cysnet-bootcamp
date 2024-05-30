Class cysnet.clinicaDental.agenda.bo.CitasSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

// Método que crea una nueva cita

Method altaCita(pRequest As cysnet.clinicaDental.agenda.msg.AltaCitaRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AltaCitaResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0

    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AltaCitaResponse).%New()
    set pResponse.exito = 1

    Try {
        
        set codEstado = 1
        set sqlCrearCita = "INSERT INTO cysnet_clinicaDental_data.Citas (IdPaciente, DescCita, FechaCita, CodEstado) VALUES (?, ?, ?, ?)"
        set sc = ..Adapter.ExecuteUpdate(.numRows, sqlCrearCita, pRequest.idPaciente, pRequest.descCita, pRequest.fechaCita, codEstado)
        
        // Revisa si la sentencia se ejecuta bien
        if ($$$ISOK(sc)) {

            // Revisa si trae resultados
            if (numRows > 0) {
                set pResponse.exito = 1
                set pResponse.mensaje = "Cita "_pRequest.descCita_" para el paciente "_pRequest.idPaciente_" creada exitosamente"
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

// Método que cancela una cita médica

Method cancelarCita(pRequest As cysnet.clinicaDental.agenda.msg.CancelarCitaRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.CancelarCitaResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet

    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.CancelarCitaResponse).%New()
    set pResponse.exito = 1

    Try {
        
        // Hacer el update del campo codEstado a 4
        set sqlCancelarCita = "UPDATE cysnet_clinicaDental_data.Pacientes SET CodEstado = 4 WHERE ID = ?"
        set sc = ..Adapter.ExecuteUpdate(.rs, sqlCancelarCita, pRequest.idCita)
        if ($$$ISOK(sc)) {
            set pResponse.mensaje = "Cita con el ID "_pRequest.idCita_" ha sido cancelada"
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

// Método que modifica una cita

Method modificarCita(pRequest As cysnet.clinicaDental.agenda.msg.ModificarCitaRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ModificarCitaResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0

    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ModificarCitaResponse).%New()
    set pResponse.exito = 1

    Try {
        
        set sqlObtenerFecha = "SELECT FechaCita FROM cysnet_clinicaDental_data.Citas WHERE ID = ?"
        set sc = ..Adapter.ExecuteQuery(.rs, sqlObtenerFecha, pRequest.idCita)
        if ($$$ISOK(sc)) {
            if (rs.Next(.sc)) {

                set sqlModCita = "UPDATE cysnet_clinicaDental_data.Pacientes SET FechaCita = ? WHERE ID = ?"

                set sc = ..Adapter.ExecuteUpdate(.numRows, sqlModCita, pRequest.fechaCitaNueva, pRequest.idCita)
                if ($$$ISOK(sc)) {
                    if (numRows > 0) {
                        set pResponse.mensaje = "Cita con el ID "_pRequest.idCita_" ha sido modificada"
                    } else {
                        set pResponse.exito = 0
                        set pResponse.mensaje = "No se actualizó ninguna cita médica"
                    }
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

// Método que lista las citas según el filtro

Method listarCitas(pRequest As cysnet.clinicaDental.agenda.msg.ListarCitasRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.ListarCitasResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0
    
    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.ListarCitasResponse).%New()
    set pResponse.citas = ##class(%ListOfObjects).%New()
    set pResponse.exito = 1

    Try {

        if (pRequest.mostrarCanceladas) {

            set sqlListaCitas = "SELECT * FROM cysnet_clinicaDental_data.Citas"

        } else {
            set sqlListaCitas = "SELECT * FROM cysnet_clinicaDental_data.Citas WHERE CodEstado <> 4"
        }
        
        set sc = ..Adapter.ExecuteQuery(.rs, sqlListaCitas)
        if ($$$ISOK(sc)) {
            while (rs.%Next()) {
                set cita = ##class(cysnet.clinicaDental.agenda.msg.struct.Cita).%New()
                set cita.idCita = rs.Get("ID")
                set cita.idPaciente = rs.Get("IdPaciente")
                set cita.descCita = rs.Get("DescCita")
                set cita.fechaCita = rs.Get("FechaCita")
                set cita.codEstado = rs.Get("CodEstado")
                do pResponse.citas.Insert(cita)
                kill cita
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
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.AltaCitaRequest">
    <Method>altaCita</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.CancelarCitaRequest">
    <Method>cancelarCita</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ModificarCitaRequest">
    <Method>modificarCita</Method>
    </MapItem>
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.ListarCitasRequest">
    <Method>listarCitas</Method>
    </MapItem>
</MapItems>
}

}
