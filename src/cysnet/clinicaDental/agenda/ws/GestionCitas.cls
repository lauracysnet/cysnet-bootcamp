Class cysnet.clinicaDental.agenda.ws.GestionCitas Extends EnsLib.SOAP.Service [ ProcedureBlock ]
{

/// Nombre de servicio web.
Parameter SERVICENAME = "GestionCitas";

/// Namespace SOAP para servicio web
Parameter NAMESPACE = "BOOTCAMP";

/// Se utilizarán namespaces de clases referenciadas en WSDL.
Parameter USECLASSNAMESPACES = 1;

// Método que crea una nueva cita

Method altaCita(idPaciente As %Integer, descCita As %String, fechaCita As %TimeStamp, codEstado As %Integer) As cysnet.clinicaDental.agenda.msg.AltaCitaResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.AltaCitaRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.AltaCitaResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.AltaCitaRequest).%New()
	set req.idPaciente = idPaciente
    set req.descCita = descCita
    set req.fechaCita = fechaCita
    set req.codEstado = codEstado
	do ..SendRequestSync("CitasSQL", req, .rsp)
	quit rsp
}

// Método que cancela una cita médica

Method cancelarCita(idCita As %Integer) As cysnet.clinicaDental.agenda.msg.CancelarCitaResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.CancelarCitaRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.CancelarCitaResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.CancelarCitaRequest).%New()
	set req.idCita = idCita
	do ..SendRequestSync("CitasSQL", req, .rsp)
	quit rsp
}

// Método que modifica una cita

Method modificarCita(idCita As %Integer, fechaCitaNueva As %TimeStamp) As cysnet.clinicaDental.agenda.msg.ModificarCitaResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.ModificarCitaRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.ModificarCitaResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.ModificarCitaRequest).%New()
	set req.idCita = idCita
	do ..SendRequestSync("CitasSQL", req, .rsp)
	quit rsp
}

// Método que lista las citas según el filtro

Method listarCitas(mostrarCanceladas As %Boolean) As cysnet.clinicaDental.agenda.msg.ListarCitasResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.ListarCitasRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.ListarCitasResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.ListarCitasRequest).%New()
	set req.mostrarCanceladas = mostrarCanceladas
	do ..SendRequestSync("CitasSQL", req, .rsp)
	quit rsp
}

// Método que crea un nuevo registro en la tabla de Admisiones

Method admitirPaciente(idCita As %Integer, fechaAdmision As %TimeStamp) As cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.AdmitirPacienteResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest).%New()
	set req.idCita = idCita
    set req.fechaAdmision = fechaAdmision
	do ..SendRequestSync("AdmisionesSQL", req, .rsp)
	quit rsp
}

// Método que crea un nuevo registro en la tabla de Altas

Method altaPaciente(idCita As %Integer, fechaAlta As %TimeStamp) As cysnet.clinicaDental.agenda.msg.AltaPacienteResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.AltaPacienteRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.AltaPacienteResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.AltaPacienteRequest).%New()
	set req.idCita = idCita
    set req.fechaAlta = fechaAlta
	do ..SendRequestSync("AltasSQL", req, .rsp)
	quit rsp
}

}
