Class cysnet.clinicaDental.agenda.msg.ListarPacientesResponse Extends Ens.Response
{

Property pacientes As list Of cysnet.clinicaDental.agenda.msg.struct.Paciente;

Storage Default
{
<Data name="ListarPacientesResponseDefaultData">
<Subscript>"ListarPacientesResponse"</Subscript>
<Value name="1">
<Value>pacientes</Value>
</Value>
</Data>
<DefaultData>ListarPacientesResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
