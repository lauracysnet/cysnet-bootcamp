Class cysnet.clinicaDental.notificaciones.bo.NotificacionesSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

// Método que crea un nuevo registro en la tabla de Altas

Method generarNotificacion(pRequest As cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionesRequest, Output pResponse As cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionesResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0

    set pResponse = ##class(cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionesResponse).%New()
    set pResponse.exito = 1

    Try {
        
        set indEnviado = 0
        set sqlInsertarNotif = "INSERT INTO cysnet_clinicaDental_data.Notificaciones (IdPaciente, Asunto, Mensaje , IndEnviado) VALUES (?, ?, ?, ?)"
        set sc = ..Adapter.ExecuteUpdate(.numRows, sqlInsertarNotif, pRequest.idPaciente, pRequest.asunto, pRequest.mensaje, indEnviado)
        
        // Revisa si la sentencia se ejecuta bien
        if ($$$ISOK(sc)) {

            // Revisa si trae resultados
            if (numRows > 0) {
                set pResponse.exito = 1
                set pResponse.mensaje = "Notificación del paciente "_pRequest.idPaciente_" con el asunto "_pRequest.asunto_" agregada exitosamente"
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
                set pResponse.mensaje = "No se insertó el registro de notificación del paciente "_pRequest.idPaciente_" con el asunto "_pRequest.asunto
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
    <MapItem MessageType="cysnet.clinicaDental.notificaciones.msg.GenerarNotificacionesRequest">
    <Method>generarNotificacion</Method>
    </MapItem>
</MapItems>
}

}
