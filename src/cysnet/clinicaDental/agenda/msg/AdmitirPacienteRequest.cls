Class cysnet.clinicaDental.agenda.msg.AdmitirPacienteRequest Extends Ens.Request
{

Property idCita As %Integer;

Property fechaAdmision As %TimeStamp;

Storage Default
{
<Data name="AdmitirPacienteRequestDefaultData">
<Subscript>"AdmitirPacienteRequest"</Subscript>
<Value name="1">
<Value>idCita</Value>
</Value>
<Value name="2">
<Value>fechaAdmision</Value>
</Value>
</Data>
<DefaultData>AdmitirPacienteRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
