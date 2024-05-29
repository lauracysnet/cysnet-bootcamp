Class cysnet.clinicaDental.agenda.data.Pacientes Extends %Persistent
{

// Nombre del paciente

Property nombre As %String;

// Apellidos del paciente

Property apellidos As %String;

// Email del paciente

Property email As %String;

// Indica si el paciente permite que se le envíen notificaciones por email o no

Property permiteNotificaciones As %Boolean;

// Indica si un paciente está dado de baja del sistema

Property baja As %Boolean;

Storage Default
{
<Data name="PacientesDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>nombre</Value>
</Value>
<Value name="3">
<Value>apellidos</Value>
</Value>
<Value name="4">
<Value>email</Value>
</Value>
<Value name="5">
<Value>permiteNotificaciones</Value>
</Value>
<Value name="6">
<Value>baja</Value>
</Value>
</Data>
<DataLocation>^cysnet.clinicaDe505B.PacientesD</DataLocation>
<DefaultData>PacientesDefaultData</DefaultData>
<IdLocation>^cysnet.clinicaDe505B.PacientesD</IdLocation>
<IndexLocation>^cysnet.clinicaDe505B.PacientesI</IndexLocation>
<StreamLocation>^cysnet.clinicaDe505B.PacientesS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod nuevoPaciente(nombre As %String, apellidos As %String, email As %String) As %Integer
{
    set paciente = ##class(cysnet.clinicaDental.agenda.data.Pacientes).%New()
    set paciente.nombre = nombre
    set paciente.apellidos = apellidos
    set paciente.email = email
    set paciente.permiteNotificaciones = 1
    set paciente.baja = 0
    set status = paciente.%Save()
    //Sacar id de la BD y retornarlo
    set status = paciente.%Id()

    // set person.fechaNacimiento = $ZDATEH(fechaNacimiento,3)

    return status
}

ClassMethod bajaPaciente(id As %Integer) As %Integer
{
    set existe = ##class(cysnet.clinicaDental.agenda.data.Pacientes).%ExistsId(id)
    if (existe = 0) {
        // No existe en la BD
        write "El ID proporcionado no existe en la base de datos",!
        set status = -1
    } else {
        set paciente = ##class(cysnet.clinicaDental.agenda.data.Pacientes).%OpenId(id)
        set paciente.baja = 1
        set status = paciente.%Save()
        //Sacar id de la BD y retornarlo
        set status = paciente.%Id()
    }

    return status
}

}
