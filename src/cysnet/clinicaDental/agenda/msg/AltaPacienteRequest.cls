Class cysnet.clinicaDental.agenda.msg.AltaPacienteRequest Extends Ens.Request
{

Property idCita As %Integer;

Property fechaAlta As %TimeStamp;

Storage Default
{
<Data name="AltaPacienteRequestDefaultData">
<Subscript>"AltaPacienteRequest"</Subscript>
<Value name="1">
<Value>idCita</Value>
</Value>
<Value name="2">
<Value>fechaAlta</Value>
</Value>
</Data>
<DefaultData>AltaPacienteRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
