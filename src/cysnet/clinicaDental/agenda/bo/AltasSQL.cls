Class cysnet.clinicaDental.agenda.bo.AltasSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

// Método que crea un nuevo registro en la tabla de Altas

Method altaPaciente(pRequest As cysnet.clinicaDental.agenda.msg.AltaPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AltaPacienteResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0

    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AltaPacienteResponse).%New()
    set pResponse.exito = 1

    Try {
        
        set sqlObtenerAlta = "SELECT idCita FROM cysnet_clinicaDental_data.Altas WHERE idCita = ?"
        set sc = ..Adapter.ExecuteQuery(.rs, sqlObtenerAlta, pRequest.idCita)
        if ($$$ISOK(sc)) {
            if (rs.Next(.sc)) {
                quit:$$$ISERR(sc)
                set pResponse.exito = 0
                set pResponse.mensaje = "Ya se le dió de alta a la cita médica con el ID "_pRequest.idCita
                return $$$OK
            }
        }
        
        set indEnviada = 0
        set sqlInsertarAlta = "INSERT INTO cysnet_clinicaDental_data.Altas (IdCita, FechaAlta , IndEnviada) VALUES (?, ?, ?)"
        set sc = ..Adapter.ExecuteUpdate(.numRows, sqlInsertarAlta, pRequest.idCita, pRequest.fechaAlta, indEnviada)
        
        // Revisa si la sentencia se ejecuta bien
        if ($$$ISOK(sc)) {

            // Revisa si trae resultados
            if (numRows > 0) {
                set pResponse.exito = 1
                set pResponse.mensaje = "Cita médica"_pRequest.idCita_" dada de alta exitosamente"
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
                set pResponse.mensaje = "No se insertó el registro de alta de la cita "_pRequest.idCita
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
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.AltaPacienteRequest">
    <Method>altaPaciente</Method>
    </MapItem>
</MapItems>
}

}
