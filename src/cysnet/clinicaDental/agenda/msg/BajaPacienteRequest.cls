Class cysnet.clinicaDental.agenda.msg.BajaPacienteRequest Extends Ens.Request
{

// Correo electrónico del paciente a dar de baja

Property email As %String;

Storage Default
{
<Data name="BajaPacienteRequestDefaultData">
<Subscript>"BajaPacienteRequest"</Subscript>
<Value name="1">
<Value>id</Value>
</Value>
<Value name="2">
<Value>email</Value>
</Value>
</Data>
<DefaultData>BajaPacienteRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
