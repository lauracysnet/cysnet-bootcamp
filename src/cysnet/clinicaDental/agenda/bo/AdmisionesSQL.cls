Class cysnet.clinicaDental.agenda.bo.AdmisionesSQL Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

// Método que crea un nuevo registro en la tabla de Admisiones

Method admitirPaciente(pRequest As cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest, Output pResponse As cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse) As %Status
{
    #dim sc As %Status = $$$OK
    #dim rs As EnsLib.SQL.GatewayResultSet
    #dim numRows As %Integer = 0
    set numRows = 0

    set pResponse = ##class(cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse).%New()
    set pResponse.exito = 1

    Try {

        set sqlObtenerAdmision = "SELECT idCita FROM cysnet_clinicaDental_data.Admisiones WHERE idCita = ?"
        set sc = ..Adapter.ExecuteQuery(.rs, sqlObtenerAdmision, pRequest.idCita)
        if ($$$ISOK(sc)) {
            if (rs.Next(.sc)) {
                quit:$$$ISERR(sc)
                set pResponse.exito = 0
                set pResponse.mensaje = "Ya existe admitida una cita médica con el ID "_pRequest.idCita
                return $$$OK
            }
        }

        // Si la cita no se encuentra registrada entonces la crea
        set indEnviada = 0
        set sqlInsertarAdmision = "INSERT INTO cysnet_clinicaDental_data.Admisiones (IdCita, FechaAdmision , IndEnviada) VALUES (?, ?, ?)"
        set sc = ..Adapter.ExecuteUpdate(.numRows, sqlInsertarAdmision, pRequest.idCita, pRequest.fechaAdmision, indEnviada)
        
        // Revisa si la sentencia se ejecuta bien
        if ($$$ISOK(sc)) {

            // Revisa si trae resultados
            if (numRows > 0) {
                set pResponse.exito = 1
                set pResponse.mensaje = "Admision de la cita "_pRequest.idCita_" agregada exitosamente"
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
                set pResponse.mensaje = "No se insertó la admisión de la cita "_pRequest.idCita
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
    <MapItem MessageType="cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest">
    <Method>admitirPaciente</Method>
    </MapItem>
</MapItems>
}

}
