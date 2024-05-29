Class cysnet.clinicaDental.agenda.msg.ModificarPacienteRequest Extends Ens.Request
{

// Correo electrónico actual

Property emailActual As %String;

// Nombre nuevo - Modificar paciente

Property nombreNuevo As %String;

// Apellidos nuevo - Modificar paciente

Property apellidosNuevo As %String;

// Correo electrónico nuevo - Modificar paciente

Property emailNuevo As %String;

// Cambio en el permiso de notificaciones - Modificar paciente

Property permiteNotificaciones As %Boolean;

Storage Default
{
<Data name="ModificarPacienteRequestDefaultData">
<Subscript>"ModificarPacienteRequest"</Subscript>
<Value name="1">
<Value>emailActual</Value>
</Value>
<Value name="2">
<Value>nombre</Value>
</Value>
<Value name="3">
<Value>apellidos</Value>
</Value>
<Value name="4">
<Value>emailNuevo</Value>
</Value>
<Value name="5">
<Value>permiteNotificaciones</Value>
</Value>
<Value name="6">
<Value>nombreActual</Value>
</Value>
<Value name="7">
<Value>apellidosActual</Value>
</Value>
<Value name="8">
<Value>nombreNuevo</Value>
</Value>
<Value name="9">
<Value>apellidosNuevo</Value>
</Value>
</Data>
<DefaultData>ModificarPacienteRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
