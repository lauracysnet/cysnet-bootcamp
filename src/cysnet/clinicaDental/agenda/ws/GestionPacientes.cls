Class cysnet.clinicaDental.agenda.ws.GestionPacientes Extends EnsLib.SOAP.Service [ ProcedureBlock ]
{

/// Nombre de servicio web.
Parameter SERVICENAME = "GestionPacientes";

/// Namespace SOAP para servicio web
Parameter NAMESPACE = "BOOTCAMP";

/// Se utilizarán namespaces de clases referenciadas en WSDL.
Parameter USECLASSNAMESPACES = 1;

// Método que crea un nuevo paciente

Method nuevoPaciente(nombre As %String, apellidos As %String, email As %String) As cysnet.clinicaDental.agenda.msg.CrearPacienteResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.CrearPacienteRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.CrearPacienteResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.CrearPacienteRequest).%New()
	set req.nombre = nombre
    set req.apellidos = apellidos
    set req.email = email
	do ..SendRequestSync("PacientesSQL", req, .rsp)
	quit rsp
}

// Método que da de baja un paciente

Method bajaPaciente(email As %String) As cysnet.clinicaDental.agenda.msg.BajaPacienteResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.BajaPacienteRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.BajaPacienteResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.BajaPacienteRequest).%New()
	set req.email = email
	do ..SendRequestSync("PacientesSQL", req, .rsp)
	quit rsp
}

// Método que modifica un paciente

Method modificarPaciente(emailActual As %String, nombreNuevo As %String, apellidosNuevo As %String, emailNuevo As %String, permiteNotificaciones As %Boolean) As cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.ModificarPacienteResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest).%New()
	set req.emailActual = emailActual
    set req.nombreNuevo = nombreNuevo
    set req.apellidosNuevo = apellidosNuevo
    set req.emailNuevo = emailNuevo
    set req.permiteNotificaciones = permiteNotificaciones
	do ..SendRequestSync("PacientesSQL", req, .rsp)
	quit rsp
}

// Método que lista a los pacientes

Method listarPacientes(mostrarBajas As %Boolean) As cysnet.clinicaDental.agenda.msg.ListarPacientesResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.ListarPacientesRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.ListarPacientesResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.ListarPacientesRequest).%New()
	set req.mostrarBajas = mostrarBajas
	do ..SendRequestSync("PacientesSQL", req, .rsp)
	quit rsp
}

// Método que muestra un paciente basado en su ID

Method buscarPacientePorID(id As %Integer) As cysnet.clinicaDental.agenda.msg.BuscarPacienteResponse [ WebMethod ]
{
    #dim req As cysnet.clinicaDental.agenda.msg.BuscarPacienteRequest
	#dim rsp As cysnet.clinicaDental.agenda.msg.BuscarPacienteResponse
	set req = ##class(cysnet.clinicaDental.agenda.msg.BuscarPacienteRequest).%New()
	set req.id = id
	do ..SendRequestSync("PacientesSQL", req, .rsp)
	quit rsp
}

}
