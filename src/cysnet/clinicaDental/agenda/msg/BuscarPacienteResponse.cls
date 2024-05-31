Class cysnet.clinicaDental.agenda.msg.BuscarPacienteResponse Extends Ens.Response
{

Property paciente As cysnet.clinicaDental.agenda.msg.struct.Paciente;

Storage Default
{
<Data name="BuscarPacienteResponseDefaultData">
<Subscript>"BuscarPacienteResponse"</Subscript>
<Value name="1">
<Value>paciente</Value>
</Value>
</Data>
<DefaultData>BuscarPacienteResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
